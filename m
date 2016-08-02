From: michael.weiser@gmx.de (Michael Weiser)
Date: Tue,  2 Aug 2016 21:31:15 +0200
Subject: [PATCH 5/5] ARM: sunxi: enable big-endian
In-Reply-To: <20160802193115.850-1-michael.weiser@gmx.de>
References: <20160802193115.850-1-michael.weiser@gmx.de>
Message-ID: <20160802193115.850-6-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With previous fixes to stmmac, sun4i-emac and sun4i-mmc at least the
Cubieboard2 incarnation of sunxi works correctly in big-endian mode.
Allow the selection of big-endian.

Tested using a Cubieboard Two-Card and the following
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
index 096ed21..cdeba4a 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
 	depends on ARCH_MULTI_V7
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
-- 
2.9.2
