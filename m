From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 12 Jul 2011 22:12:25 +0800
Subject: [PATCH] i.MX53: Initial Ka-Ro electronics TX53 board support
In-Reply-To: <20110712135046.GU6069@pengutronix.de>
References: <1310469518-23615-1-git-send-email-LW@KARO-electronics.de>
	<20110712115146.GC19105@S2100-06.ap.freescale.net>
	<20110712135046.GU6069@pengutronix.de>
Message-ID: <20110712141225.GD19105@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 03:50:46PM +0200, Sascha Hauer wrote:
> On Tue, Jul 12, 2011 at 07:51:47PM +0800, Shawn Guo wrote:
> > On Tue, Jul 12, 2011 at 01:18:38PM +0200, Lothar Wa?mann wrote:
> > > This patch adds initial board support for the Ka-Ro electronics TX53
> > > processor module (MACH_TX53).
> > > 
> > > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > > ---
> > >  arch/arm/mach-mx5/Kconfig                   |   15 +
> > >  arch/arm/mach-mx5/Makefile                  |    1 +
> > >  arch/arm/mach-mx5/board-tx53.c              |  400 +++++++++++++++++++++++++++
> > >  arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
> > >  4 files changed, 417 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/mach-mx5/board-tx53.c
> > > 
> > I'm not sure if it makes sense to add another board support, while
> > we are migrating to device tree.
> 
> I would agree if device tree was complete, but do we really want to
> block all new boards for unspecified time?
> 
I would not think it is an unspecified time.  I'm working pretty hard
to convert all i.mx53 boards to device tree, hopefully on v3.2 window.
Let's see where we are.  If you agree, we have done serial, fec, gpio, 
esdhc, spi.  And i2c and sdma dt patches will be sent out shortly.

+config MACH_TX53
+       bool "Support Ka-Ro electronics TX53 module"
+       select SOC_IMX53
+       select IMX_HAVE_PLATFORM_GPIO_KEYS
+       select IMX_HAVE_PLATFORM_IMX2_WDT
+       select IMX_HAVE_PLATFORM_IMX_UART
+       select IMX_HAVE_PLATFORM_IMX_I2C
+       select IMX_HAVE_PLATFORM_MXC_EHCI
+       select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+       select IMX_HAVE_PLATFORM_SPI_IMX
+       select LEDS_GPIO_REGISTER

So, gpio_keys, wdt, ehci, led are missing.  I hope I can get them
migrated to dt by v3.2.

-- 
Regards,
Shawn
