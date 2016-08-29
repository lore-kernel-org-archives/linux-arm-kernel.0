From: w.egorov@phytec.de (Wadim Egorov)
Date: Mon, 29 Aug 2016 13:33:31 +0200
Subject: [PATCH] ARM: rockchip: add UART0 as debug uart for RK32xx based
 platforms
Message-ID: <1472470411-46922-1-git-send-email-w.egorov@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to allow low-level debugging messages via Rockchip RK32 UART0.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/Kconfig.debug | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index a9693b6..5b0d6dd 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -831,6 +831,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
 
+	config DEBUG_RK32_UART0
+		bool "Kernel low-level debugging messages via Rockchip RK32 UART0"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip RK32xx based platforms.
+
 	config DEBUG_RK32_UART2
 		bool "Kernel low-level debugging messages via Rockchip RK32 UART2"
 		depends on ARCH_ROCKCHIP
@@ -1531,6 +1539,7 @@ config DEBUG_UART_PHYS
 	default 0xfcb00000 if DEBUG_HI3620_UART
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfe800000 if ARCH_IOP32X
+	default 0xff180000 if DEBUG_RK32_UART0
 	default 0xff690000 if DEBUG_RK32_UART2
 	default 0xffc02000 if DEBUG_SOCFPGA_UART0
 	default 0xffc02100 if DEBUG_SOCFPGA_UART1
@@ -1631,6 +1640,7 @@ config DEBUG_UART_VIRT
 	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
 	default 0xfec20000 if DEBUG_SIRFATLAS7_UART1
 	default 0xfec60000 if DEBUG_SIRFPRIMA2_UART1
+	default 0xfe780000 if DEBUG_RK32_UART0
 	default 0xfec90000 if DEBUG_RK32_UART2
 	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
 	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2
@@ -1677,8 +1687,8 @@ config DEBUG_UART_8250_WORD
 		DEBUG_ALPINE_UART0 || \
 		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
 		DEBUG_DAVINCI_DA8XX_UART2 || \
-		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
-		DEBUG_BRCMSTB_UART
+		DEBUG_BCM_KONA_UART || DEBUG_BRCMSTB_UART || \
+		DEBUG_RK32_UART0 || DEBUG_RK32_UART2
 
 config DEBUG_UART_8250_PALMCHIP
 	bool "8250 UART is Palmchip BK-310x"
-- 
1.9.1
