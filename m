From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 15 Dec 2009 14:59:03 +0100
Subject: [PATCH V2] Driver for the watchdog timer on all Freescale IMX
	processors.
In-Reply-To: <20091215120229.GJ4291@infomag.iguana.be>
References: <20091209091244.GA15126@pengutronix.de>
	<1260786235-32629-1-git-send-email-w.sang@pengutronix.de>
	<20091215120229.GJ4291@infomag.iguana.be>
Message-ID: <20091215135903.GB3120@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wim,

> Some general feedback first:
> * The MX2 and MX3 series have a watchdog device that cannot be stopped once
> started. Since we use /dev/watchdog to start and stop the hardware, we
> normally introduce a timer to keep the watchdog alive when /dev/watchdog
> is closed. This is missing in this driver.
> (See drivers/watchdog/at91sam9_wdt.c as an example).

Will do. Thanks for the pointer!

> * The MX1 platform is 32 bit instead of 16 bit and can be stopped and started.
> Maybe it would make sense to split this in 2 drivers (one for MX1 and one for
> the others).

Hmm, originally I'd prefer to keep the two sticked together. But as we seem to
need a seperate timer now for MX2/3, it might probably pay off to seperate
them. I will have a look.

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091215/df7ad9a1/attachment.sig>
