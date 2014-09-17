From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Wed, 17 Sep 2014 22:24:14 +0800
Subject: [PATCH v2 7/7] arm: mediatek: Add earlyprintk support for mt8127 &
 mt8135
In-Reply-To: <1410963854-17154-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1410963854-17154-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <1410963854-17154-8-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Enable low-level debug for Mediatek mt8127 & mt8135 SoC.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 arch/arm/Kconfig.debug | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index cfdd1c0..3888d17 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -842,6 +842,22 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  for Mediatek mt6589 based platforms on UART0.
 
+	config DEBUG_MT8127_UART0
+		bool "Mediatek mt8127 UART0"
+		depends on ARCH_MEDIATEK
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  for Mediatek mt8127 based platforms on UART0.
+
+	config DEBUG_MT8135_UART3
+		bool "Mediatek mt8135 UART3"
+		depends on ARCH_MEDIATEK
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  for Mediatek mt8135 based platforms on UART3.
+
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
@@ -1084,6 +1100,8 @@ config DEBUG_UART_PHYS
 	default 0x101f1000 if ARCH_VERSATILE
 	default 0x101fb000 if DEBUG_NOMADIK_UART
 	default 0x11006000 if DEBUG_MT6589_UART0
+	default 0x11002000 if DEBUG_MT8127_UART0
+	default 0x11009000 if DEBUG_MT8135_UART3
 	default 0x16000000 if ARCH_INTEGRATOR
 	default 0x18000300 if DEBUG_BCM_5301X
 	default 0x1c090000 if DEBUG_VEXPRESS_UART0_RS1
@@ -1147,6 +1165,8 @@ config DEBUG_UART_VIRT
 	default 0xf0201000 if DEBUG_BCM2835
 	default 0xf1000300 if DEBUG_BCM_5301X
 	default 0xf1006000 if DEBUG_MT6589_UART0
+	default 0xf1002000 if DEBUG_MT8127_UART0
+	default 0xf1009000 if DEBUG_MT8135_UART3
 	default 0xf11f1000 if ARCH_VERSATILE
 	default 0xf1600000 if ARCH_INTEGRATOR
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
-- 
1.8.1.1.dirty
