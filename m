From: michael.weiser@gmx.de (Michael Weiser)
Date: Mon, 22 Aug 2016 18:42:19 +0200
Subject: [PATCH 5/5] ARM: sunxi: enable big-endian
In-Reply-To: <20160822164219.14272-1-michael.weiser@gmx.de>
References: <20160822164219.14272-1-michael.weiser@gmx.de>
Message-ID: <20160822164219.14272-6-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With previous fixes to stmmac, sun4i-emac and sun4i-mmc at least the
Cubieboard2 incarnation of sunxi works correctly in big-endian mode.
Allow the selection of big-endian.

Tested using a Cubieboard2 DualCard and the following
hardware-components:
- GMAC (stmmac)
- EMAC (sun4i-emac)
- SATA
- SPI
- UART
- security system
- touchscreen controller hwmon functionality
- pinctrl (custom interrupt for SPI ethernet controller)
- watchdog as reset controller
- onboard RTC
- DS1307 I2C RTC
- sound codec and with this indirectly the DMA engine

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 096ed21..e564a73 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -34,6 +34,7 @@ config MACH_SUN7I
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
 	select SUN5I_HSTIMER
+	select ARCH_SUPPORTS_BIG_ENDIAN
 
 config MACH_SUN8I
 	bool "Allwinner sun8i Family SoCs support"
-- 
2.9.2
