From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Sep 2014 20:58:19 +0100
Subject: [PATCH v2] spi: davinci: add support for adding delay between
 word's transmission
In-Reply-To: <540F44EB.8090700@ti.com>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
 <20140909165555.GD2601@sirena.org.uk> <540F3447.3020609@ti.com>
 <20140909172057.GH2601@sirena.org.uk> <540F44EB.8090700@ti.com>
Message-ID: <20140909195819.GJ2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 02:20:27PM -0400, Murali Karicheri wrote:
> On 09/09/2014 01:20 PM, Mark Brown wrote:

> >If these delays are not related to chip select then the documentation
> >needs to be fixed to not refer to chip select.

> Ok. So what I understand is the issue is not having the right description to
> indicate that these parameters are delays associated with tranmission of
> successive words on the wire. Personally I like these description match with
> what is described in the device spec/ user guide and what is described above
> match with that. However we could add additional description as below to to
> make it more explicit.

> spi-c2t-delay - delay after CS is asserted before output bits on wire
> spi-t2c-delay - delay after tramission of bits and before deasserting CS

> Do you think this will help?

No, that doesn't help at all.  You keep claiming that these parameters
are related to the intervals between words but then providing
descriptions of these parameters which relate to intervals around
changes in /CS which is patently not something connected with the gaps
between words.  Either your description of parameters which do not
relate to /CS should not need to mention /CS or the parameters are in
fact related to /CS, both can't simultaneously be true.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/8daba7ee/attachment.sig>
