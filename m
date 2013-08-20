From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 20 Aug 2013 10:31:03 +0800
Subject: [PATCH v7 01/11] ARM: debug: support debug ll on hisilicon soc
In-Reply-To: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1376965873-14431-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support UART0 debug ll on Hisilicon Hi3620 SoC & Hi3716 SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig.debug | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 814d224..bba9662 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -194,6 +194,22 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on HI3716 UART.
 
+	config DEBUG_HI3620_UART
+		bool "Hisilicon HI3620 Debug UART"
+		depends on ARCH_HI3xxx
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HI3620 UART.
+
+	config DEBUG_HI3716_UART
+		bool "Hisilicon Hi3716 Debug UART"
+		depends on ARCH_HI3xxx
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HI3716 UART.
+
 	config DEBUG_HIGHBANK_UART
 		bool "Kernel low-level debugging messages via Highbank UART"
 		depends on ARCH_HIGHBANK
@@ -980,6 +996,8 @@ config DEBUG_UART_PHYS
 	default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
 	default 0xf1012000 if ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
 				ARCH_ORION5X
+	default 0xf8b00000 if DEBUG_HI3716_UART
+	default 0xfcb00000 if DEBUG_HI3620_UART
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xffc02000 if DEBUG_SOCFPGA_UART
 	default 0xffd82340 if ARCH_IOP13XX
@@ -1016,6 +1034,7 @@ config DEBUG_UART_VIRT
 	default 0xfe100000 if DEBUG_IMX23_UART || DEBUG_IMX28_UART
 	default 0xfe230000 if DEBUG_PICOXCELL_UART
 	default 0xfe800000 if ARCH_IOP32X
+	default 0xfeb00000 if DEBUG_HI3620_UART || DEBUG_HI3716_UART
 	default 0xfeb24000 if DEBUG_RK3X_UART0
 	default 0xfeb26000 if DEBUG_RK3X_UART1
 	default 0xfeb30c00 if DEBUG_KEYSTONE_UART0
-- 
1.8.1.2
