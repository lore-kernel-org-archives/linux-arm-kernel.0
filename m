From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Aug 2013 11:31:24 +0100
Subject: [PATCH V3 2/3] ASoC: Samsung: I2S: Add quirks as driver data in
 I2S
In-Reply-To: <CAAgF-BdpsgQk8myq7OOk5zJ8Zxy+J6LUPb3-d40+iE2aNwdwDw@mail.gmail.com>
References: <1375865122-5258-1-git-send-email-padma.v@samsung.com>
 <1375865122-5258-3-git-send-email-padma.v@samsung.com>
 <2116389.OxrlCQ9LXd@amdc1227>
 <CAAgF-BdpsgQk8myq7OOk5zJ8Zxy+J6LUPb3-d40+iE2aNwdwDw@mail.gmail.com>
Message-ID: <20130808103124.GU6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 01:13:02PM +0530, Padma Venkat wrote:

> If legacy platforms not required to change then I need to introduce a
> new samsung_i2s_dai_data structure which holds only dai_type for
> non-dt platforms. If I change legacy platforms it breaks the older
> platforms now. Is it okay adding a samsung_i2s_dai_data structure for
> non-dt platforms which will be removed later?

This is totally fine and looks much nicer - you're not creating DT style
names in the platform bus, nor making names that are so long that we
need to expand the maximum length of a plaform device name (which isn't
awesome).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/3311f5b7/attachment.sig>
