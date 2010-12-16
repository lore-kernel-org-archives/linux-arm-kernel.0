From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 16 Dec 2010 10:20:32 +0100
Subject: [PATCHv2] mc13xxx: Add i2c support for mc13xxx-core
In-Reply-To: <20101216090210.GE1940@pengutronix.de>
References: <1292449675-20308-1-git-send-email-marc@cpdesign.com.au>
	<20101216074730.GD1940@pengutronix.de>
	<201012161930.17299.marc@cpdesign.com.au>
	<20101216090210.GE1940@pengutronix.de>
Message-ID: <20101216092032.GA4209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

>      (BTW, did you fix the dependencies?  Currently you need to depend
>      on I2C && SPI.  (Not sure these are the correct names, you may want
>      to double check that.))

Be careful, this is a subtle issue. You will get unresolved symbols if your
chip is connected via SPI, and <driver>=y, SPI=y, together with I2C=m. Been
there.

>      This is more flexible but IMHO not worth the effort.

I had to do it back then :( I wondered if there couldn't be a generic way to
deal with SPI+I2C-drivers, never got to investigate it, though.

Also, be sure to CC i2c- and spi-lists when you do the next version.

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101216/46476a3c/attachment-0001.sig>
