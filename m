From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 16 Nov 2012 15:17:47 +0200
Subject: [PATCH v2 5/7] usb: chipidea: usbmisc: add support for ahb,
 ipg and per clock
In-Reply-To: <1352981028-14312-6-git-send-email-m.grzeschik@pengutronix.de>
References: <1352981028-14312-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352981028-14312-6-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <87r4nt6610.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:

> From: Marc Kleine-Budde <mkl@pengutronix.de>
>
> This patch adds support for a second and third clock to the usbmisc driver. On
> modern freescale ARM cores like the imx51, imx53 and imx6q three clocks ("ahb",
> "ipg" and "per") must be enabled in order to access the USB core.
>
> ahb - AMBA High-Performance Bus clock domain
> ipg - IP-Bus Gate clock domain
> per - Peripheral clock domain

Looks like usbmisc_imx and ci13xxx_imx are growing more and more common
code.
Btw, shouldn't there be a way to specify platform's clock tree
configuration via devicetree or whatnot so that each platform driver
didn't have to request platform specific clocks?

Regards,
--
Alex
