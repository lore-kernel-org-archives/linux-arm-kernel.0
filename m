From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 May 2014 19:47:04 +0800
Subject: [PATCH 05/20] ARM: imx5: remove i.MX5 non-DT device registration
 helpers
In-Reply-To: <1400576552.352489173@f117.i.mail.ru>
References: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
 <1400575538-21136-6-git-send-email-shawn.guo@freescale.com>
 <1400576552.352489173@f117.i.mail.ru>
Message-ID: <20140520114700.GA20778@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 01:02:32PM +0400, Alexander Shiyan wrote:
> Tue, 20 May 2014 16:45:23 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> > i.MX5 is DT only platforms, so these non-DT device registration helpers
> > is used nowhere.  Remove them.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-imx/devices/platform-fec.c           | 12 ----------
> >  arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c  |  5 ----
> >  arch/arm/mach-imx/devices/platform-imx-i2c.c       | 26 ---------------------
> >  arch/arm/mach-imx/devices/platform-imx-keypad.c    | 10 --------
> >  arch/arm/mach-imx/devices/platform-imx-ssi.c       | 20 ----------------
> >  arch/arm/mach-imx/devices/platform-imx-uart.c      | 22 ------------------
> >  arch/arm/mach-imx/devices/platform-imx2-wdt.c      | 18 ---------------
> >  arch/arm/mach-imx/devices/platform-mxc-ehci.c      |  9 --------
> >  arch/arm/mach-imx/devices/platform-mxc_nand.c      |  5 ----
> >  arch/arm/mach-imx/devices/platform-pata_imx.c      | 10 --------
> >  .../mach-imx/devices/platform-sdhci-esdhc-imx.c    | 24 -------------------
> >  arch/arm/mach-imx/devices/platform-spi_imx.c       | 27 ----------------------
> 
> Seems, as an follow patch we should also remove SOC_IMX5* symbol
> dependencies from arch/arm/mach-imx/devices/Kconfig.

Ah, yes.  I just amended the following change into the patch.

Shawn

diff --git a/arch/arm/mach-imx/devices/Kconfig b/arch/arm/mach-imx/devices/Kconfig
index 2d260a5..e40a0ab 100644
--- a/arch/arm/mach-imx/devices/Kconfig
+++ b/arch/arm/mach-imx/devices/Kconfig
@@ -1,6 +1,6 @@
 config IMX_HAVE_PLATFORM_FEC
        bool
-       default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
+       default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35

 config IMX_HAVE_PLATFORM_FLEXCAN
        bool
@@ -10,7 +10,6 @@ config IMX_HAVE_PLATFORM_FSL_USB2_UDC

 config IMX_HAVE_PLATFORM_GPIO_KEYS
        bool
-       default y if SOC_IMX51

 config IMX_HAVE_PLATFORM_IMX21_HCD
        bool
