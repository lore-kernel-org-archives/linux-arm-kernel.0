From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 11 Mar 2012 12:50:18 +0100
Subject: mfd: mc13xxx: add I2C support, V2
In-Reply-To: <1331429402-9639-1-git-send-email-marc@cpdesign.com.au>
References: <1331429402-9639-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120311115018.GA16825@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The only issue from V1 [0] not addressed is the use of regmap - mainly, I don't
> have the time. I accept that this is a lame excuse but hope that use of regmap 
> can come later if it is required.

I really appreciate the effort, yet I fear that this is a show stopper. It gets
open coded what regmap is trying to abstract, adding complexity to the driver
instead of (probably) reducing it. We could also get caching basically for
free, if this is desired. I think the regmap approach should have been tried
before we go custom. sound/soc/codecs/ad193x.c might give an impression how
regmap spi/i2c in one driver could look like.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120311/e5080873/attachment.sig>
