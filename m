From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 9 Dec 2011 09:01:48 +0800
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
Message-ID: <20111209010147.GH7913@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 03:14:40PM -0800, Stephen Warren wrote:
> Presumably, the set of pins, groups, and functions is determined by the
> SoC HW. Platform data is usually board-specific rather than SoC specific.
> You have two choices here: You could either parse this data from device
> tree as Arnd suggested (and I think as the TI OMAP pinctrl driver will),
> or do what I've done in the Tegra pinctrl driver, and simply put each
> SoC's data into the driver and select which one to use based on the DT
> compatible flag; I didn't see the point of putting data in to the DT that
> was identical for every board using a given SoC.
> 
I'm not sure about tegra, but for imx, it's very difficult to enumerate
all these data and list them in pinctrl driver.  Sascha gave a few
examples when we discussed about it in another thread.  The TX and RX
pin of UART has 4 options each.  SD could possibly have 1, 4, and 8
data lines.  Display interface could have 16, 24, 32 data lines, etc.
All these options are chosen by board design for given soc pinmux
design.  So putting this data into device tree makes sense for imx too.

-- 
Regards,
Shawn
