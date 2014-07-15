From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 16 Jul 2014 01:00:46 +0200
Subject: [PATCH 2/6] ARM: rockchip: add debug uart used by rk3288
In-Reply-To: <1471578.ILeMmG2DL6@diego>
References: <1471578.ILeMmG2DL6@diego>
Message-ID: <2866950.oXmKFGy9mh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uarts on rk3288 are still compatible with the dw_8250, but located
at a different position and need DEBUG_UART_8250_WORD enabled.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig.debug | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595..f68def0 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -613,6 +613,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
 
+	config DEBUG_RK32_UART2
+		bool "Kernel low-level debugging messages via Rockchip RK32 UART2"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip RK32xx based platforms.
+
 	config DEBUG_S3C_UART0
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
@@ -1096,6 +1104,7 @@ config DEBUG_UART_PHYS
 	default 0xf991e000 if DEBUG_QCOM_UARTDM
 	default 0xfcb00000 if DEBUG_HI3620_UART
 	default 0xfe800000 if ARCH_IOP32X
+	default 0xff690000 if DEBUG_RK32_UART2
 	default 0xffc02000 if DEBUG_SOCFPGA_UART
 	default 0xffd82340 if ARCH_IOP13XX
 	default 0xfff36000 if DEBUG_HIGHBANK_UART
@@ -1152,6 +1161,7 @@ config DEBUG_UART_VIRT
 	default 0xfec02000 if DEBUG_SOCFPGA_UART
 	default 0xfec12000 if DEBUG_MVEBU_UART || DEBUG_MVEBU_UART_ALTERNATE
 	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
+	default 0xfec90000 if DEBUG_RK32_UART2
 	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
 	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2
 	default 0xfed12000 if ARCH_KIRKWOOD
@@ -1186,7 +1196,7 @@ config DEBUG_UART_8250_WORD
 		ARCH_KEYSTONE || \
 		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
 		DEBUG_DAVINCI_DA8XX_UART2 || \
-		DEBUG_BCM_KONA_UART
+		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2
 
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
-- 
1.9.0
