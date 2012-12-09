From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 9 Dec 2012 16:26:08 +0900
Subject: [PATCH V4 0/2] Add DT support for i2s
In-Reply-To: <CAAgF-BenOdFJK2LMot73_B=wHOFgD2sq8x-Ou=1CvpkiJpmeQQ@mail.gmail.com>
References: <1354099669-1735-1-git-send-email-padma.v@samsung.com>
 <CAAgF-Bc4t6WL4vswP6CFeSQrPZBmOuYfVt6_JoB1Za9TBX7mvA@mail.gmail.com>
 <20121206041141.GA10867@opensource.wolfsonmicro.com>
 <20121207135131.A53643E0B87@localhost>
 <CAAgF-BenOdFJK2LMot73_B=wHOFgD2sq8x-Ou=1CvpkiJpmeQQ@mail.gmail.com>
Message-ID: <20121209072607.GD6511@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 08, 2012 at 10:07:54AM +0530, Padma Venkat wrote:

> Samsung i2s driver registers the platform device twice one for the
> samsung-i2s.0,1 or 2 and two for samsung-i2s.4(which actually doesn't
> represent any H/W peripheral). The max number of I2S blocks on any
> Samsung SoC are 3, the secondary device registration starts with
> device number 4.The second time registration is for the secondary fifo
> interface of a CPU dai if any exists.

> With DT support the device number in the driver is always -1, I used
> alias id for the above purpose.

So, the thing here is that while the numbers were totally OK for
platform device use they really don't fit into DT at all well.  I think
the thing here is to either have a node for the second CPU side DAI or
to have a single DT link automatically expanded into two DAI links.  I
think the second option is much better - there's only one link on the
board, it just happens to get expanded into two the way things are
currently implemented in ASoC.

This stuff probably also ought to be moved over to soc-pcm as well by
the way.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121209/68c7a3a4/attachment.sig>
