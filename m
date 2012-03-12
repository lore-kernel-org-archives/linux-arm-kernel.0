From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 12 Mar 2012 12:06:24 +0100
Subject: iMX53 and MMC_CAP_SDIO_IRQ
In-Reply-To: <4F5DD28F.50600@linuxtv.org>
References: <4F5DB793.3080904@linuxtv.org>
 <20120312101037.GA2459@pengutronix.de> <4F5DD28F.50600@linuxtv.org>
Message-ID: <20120312110624.GB2459@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Ok, to sum this up:
> 
> SDIO IRQs are working in mx_sdhci in the Freescale tree because it was
> properly implemented and tested, obviously.

Not sure about "properly", but, yes ;)

> SDIO IRQs are working for sdhci in mainline probably for other
> non-freescale platforms.

Probably, but I can't say 'yes' for sure. You'd need to find out.

> You fixed the generic sdhci driver in mainline to work with iMX53 to get
> rid of the need for mx_sdhci, but probably never got the chance to test
> if SDIO IRQs are really working.

I worked mainly with MX25/35 back then, and a little bit with MX51. IIRC
I only had an SDIO card for which no Linux drivers were available, so I
only could test that the card was detected :(

> That means, the subtle difference between mx_sdhci and sdhci to get SDIO
> IRQS to work on sdhci with iMX53 has yet to be found.

Yup. Try 'git log --follow sdhci-esdhc-imx.c' to find people who worked
with MX53 or SDIO using that driver.

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/fa9e24dc/attachment-0001.sig>
