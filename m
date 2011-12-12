From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Dec 2011 15:37:50 +0100
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <CACRpkdYpq1phHTTLy875xSr-upiW5BmvKMPO_d-niG+-J14t9w@mail.gmail.com>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
 <20111209010147.GH7913@S2100-06.ap.freescale.net>
 <4EE18403.30604@nvidia.com>
 <20111209043220.GJ7913@S2100-06.ap.freescale.net>
 <4EE192DC.3080209@nvidia.com>
 <20111209051413.GK7913@S2100-06.ap.freescale.net>
 <20111209110807.GG27267@pengutronix.de>
 <CACRpkdYpq1phHTTLy875xSr-upiW5BmvKMPO_d-niG+-J14t9w@mail.gmail.com>
Message-ID: <20111212143750.GA27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 10, 2011 at 01:18:43AM +0100, Linus Walleij wrote:
> On Fri, Dec 9, 2011 at 12:08 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > I still think it should be "I'm board Y, please set all my pins up for me"
> 
> This is basically what the current pinmux hog concept does.
> 
> > Drivers should not be bothered with pin muxing *at all*.
> 
> Not if they are simple. Like - set them up once and for all and
> then forget about it.
> 
> It gets problematic when we get to sleep states and the system
> need to reconfigure all pins on say idle or deep sleep.

If you need to reconfigure your pins in deep sleep and you control
the pins in the driver this seems to suggest that your device won't
suspend properly if the driver is not loaded?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
