From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 31 Jul 2014 18:42:20 +0200
Subject: [PATCH 4/7] arm: mediatek: Add earlyprintk support for mt6589
In-Reply-To: <1406824943-24052-1-git-send-email-matthias.bgg@gmail.com>
References: <1406824943-24052-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1406824943-24052-5-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable low-level debug for Mediatek mt6589 SoC on UART0.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/Kconfig.debug |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595..8ee127e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -818,6 +818,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Ux500 based platforms.
 
+	config DEBUG_MT6589_UART0
+		bool "Mediatek mt6589 UART0"
+		depends on ARCH_MEDIATEK
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  for Mediatek mt6589 based platforms on UART0.
+
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
@@ -1053,6 +1061,7 @@ config DEBUG_UART_PHYS
 	default 0x10126000 if DEBUG_RK3X_UART1
 	default 0x101f1000 if ARCH_VERSATILE
 	default 0x101fb000 if DEBUG_NOMADIK_UART
+	default 0x11006000 if DEBUG_MT6589_UART0
 	default 0x16000000 if ARCH_INTEGRATOR
 	default 0x18000300 if DEBUG_BCM_5301X
 	default 0x1c090000 if DEBUG_VEXPRESS_UART0_RS1
@@ -1114,6 +1123,7 @@ config DEBUG_UART_VIRT
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
 	default 0xf0201000 if DEBUG_BCM2835
 	default 0xf1000300 if DEBUG_BCM_5301X
+	default 0xf1006000 if DEBUG_MT6589_UART0
 	default 0xf11f1000 if ARCH_VERSATILE
 	default 0xf1600000 if ARCH_INTEGRATOR
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
-- 
1.7.9.5
