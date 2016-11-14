From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 14 Nov 2016 20:12:35 +0800
Subject: [PATCH v2 07/10] ARM: add low level debug uart for rk1108
In-Reply-To: <1479124550-24037-1-git-send-email-andy.yan@rock-chips.com>
References: <1479124550-24037-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1479125555-24465-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK1108 UARTs are Synopsis DesignWare 8250 compatible.
Only with different register addresses.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Jacob Chen <jacob2.chen@rock-chips.com>
---

Changes in v2: None

 arch/arm/Kconfig.debug | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d83f7c3..408540f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -776,6 +776,30 @@ choice
 		  their output to the standard serial port on the RealView
 		  PB1176 platform.
 
+	config DEBUG_RK1108_UART0
+		bool "Kernel low-level debugging messages via Rockchip RK1108 UART0"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+                  on Rockchip RK1108 based platforms.
+
+	config DEBUG_RK1108_UART1
+		bool "Kernel low-level debugging messages via Rockchip RK1108 UART1"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip RK1108 based platforms.
+
+	config DEBUG_RK1108_UART2
+		bool "Kernel low-level debugging messages via Rockchip RK1108 UART2"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip RK1108 based platforms.
+
 	config DEBUG_RK29_UART0
 		bool "Kernel low-level debugging messages via Rockchip RK29 UART0"
 		depends on ARCH_ROCKCHIP
@@ -1465,6 +1489,9 @@ config DEBUG_UART_PHYS
 	default 0x10126000 if DEBUG_RK3X_UART1
 	default 0x101f1000 if DEBUG_VERSATILE
 	default 0x101fb000 if DEBUG_NOMADIK_UART
+	default 0x10210000 if DEBUG_RK1108_UART2
+	default 0x10220000 if DEBUG_RK1108_UART1
+	default 0x10230000 if DEBUG_RK1108_UART0
 	default 0x11002000 if DEBUG_MT8127_UART0
 	default 0x11006000 if DEBUG_MT6589_UART0
 	default 0x11009000 if DEBUG_MT8135_UART3
@@ -1563,6 +1590,9 @@ config DEBUG_UART_PHYS
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
+	default 0xc881f000 if DEBUG_RK1108_UART2
+	default 0xc8821000 if DEBUG_RK1108_UART1
+	default 0xc8912000 if DEBUG_RK1108_UART0
 	default 0xe0000a00 if DEBUG_NETX_UART
 	default 0xe0010fe0 if ARCH_RPC
 	default 0xf0000be0 if ARCH_EBSA110
-- 
2.7.4
