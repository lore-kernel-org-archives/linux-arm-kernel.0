From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 7 Jul 2013 12:22:07 +0200
Subject: [PATCH] ARM: dts: imx27 phyCARD-S remove wrong I2C RTC
In-Reply-To: <1373100718.107651915@f159.i.mail.ru>
References: <1372782469.486055292@f129.mail.ru>
 <1373031909-16178-1-git-send-email-mpa@pengutronix.de>
 <1373100718.107651915@f159.i.mail.ru>
Message-ID: <20130707102207.GI16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 12:51:58PM +0400, Alexander Shiyan wrote:
> > Fixup of commit 7874d595b78e431f0f661d2fe47625649308a52e
> > "ARM: dts: Add device tree support for phycard pca100".
> > 
> > Remove wrong I2C RTC node.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> > 
> > Thanks, Alexander, you are right. I2C2 has no RTC.
> ...
> 
> There are a couple of comments on this file.
> 
> I think that the OWIRE should be moved to the RDK.

I moved OWIRE and i2c1 to RDK. Both are not used on the SOM.

> ioexpander must contain "gpio-controller" at least, and for use it further,
> it is necessary to define the label for this node.

I checked all I2C devices in the board schematics. There is actually no
ioexpander. I don't know why it was added. I will send some I2C patches
later.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
