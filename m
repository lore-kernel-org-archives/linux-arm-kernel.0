From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 26 Jun 2014 12:05:41 +0800
Subject: [PATCH v4 2/8] ARM: debug: add HiP04 debug uart
In-Reply-To: <1403755547-623-1-git-send-email-haojian.zhuang@linaro.org>
References: <1403755547-623-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1403755547-623-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the support of Hisilicon HiP04 debug uart.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595..f64a6df 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -223,6 +223,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on HI3716 UART.
 
+	config DEBUG_HIP04_UART
+		bool "Hisilicon HiP04 Debug UART"
+		depends on ARCH_HIP04
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HIP04 UART.
+
 	config DEBUG_HIGHBANK_UART
 		bool "Kernel low-level debugging messages via Highbank UART"
 		depends on ARCH_HIGHBANK
@@ -1087,6 +1095,7 @@ config DEBUG_UART_PHYS
 	default 0xd4017000 if DEBUG_MMP_UART2
 	default 0xd4018000 if DEBUG_MMP_UART3
 	default 0xe0000000 if ARCH_SPEAR13XX
+	default 0xe4007000 if DEBUG_HIP04_UART
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
 	default 0xf1012000 if ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
@@ -1128,6 +1137,7 @@ config DEBUG_UART_VIRT
 	default 0xf7008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
 				DEBUG_S3C2410_UART2)
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
+	default 0xf8007000 if DEBUG_HIP04_UART
 	default 0xf8009000 if DEBUG_VEXPRESS_UART0_CA9
 	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
 	default 0xfa71e000 if DEBUG_QCOM_UARTDM
-- 
1.9.1
