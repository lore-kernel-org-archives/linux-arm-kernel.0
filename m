From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 12 May 2014 09:30:32 +0800
Subject: [PATCH 1/5] ARM: debug: Rename Hi3716 to HI5XHD2
In-Reply-To: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399858236-29027-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haifeng Yan <yanhaifeng@gmail.com>

Rename Hisilicon HI3716 to HI5XHD2. And it relies on ARCH_HI5XHD2
instead.

Signed-off-by: Haifeng Yan <yanhaifeng@gmail.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig.debug | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5a311af..df930e5 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -215,14 +215,6 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on HI3620 UART.
 
-	config DEBUG_HI3716_UART
-		bool "Hisilicon Hi3716 Debug UART"
-		depends on ARCH_HI3xxx
-		select DEBUG_UART_PL01X
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  on HI3716 UART.
-
 	config DEBUG_HIP04_UART
 		bool "Hisilicon HiP04 Debug UART"
 		depends on ARCH_HIP04
@@ -231,6 +223,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on HIP04 UART.
 
+	config DEBUG_HIX5HD2_UART
+		bool "Hisilicon Hix5hd2 Debug UART"
+		depends on ARCH_HIX5HD2
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Hix5hd2 UART.
+
 	config DEBUG_HIGHBANK_UART
 		bool "Kernel low-level debugging messages via Highbank UART"
 		depends on ARCH_HIGHBANK
@@ -1058,7 +1058,7 @@ config DEBUG_UART_PHYS
 	default 0xf1012000 if ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
 				ARCH_ORION5X
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
-	default 0xf8b00000 if DEBUG_HI3716_UART
+	default 0xf8b00000 if DEBUG_HIX5HD2_UART
 	default 0xfcb00000 if DEBUG_HI3620_UART
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xffc02000 if DEBUG_SOCFPGA_UART
@@ -1101,7 +1101,7 @@ config DEBUG_UART_VIRT
 	default 0xfe230000 if DEBUG_PICOXCELL_UART
 	default 0xfe300000 if DEBUG_BCM_KONA_UART
 	default 0xfe800000 if ARCH_IOP32X
-	default 0xfeb00000 if DEBUG_HI3620_UART || DEBUG_HI3716_UART
+	default 0xfeb00000 if DEBUG_HI3620_UART || DEBUG_HIX5HD2_UART
 	default 0xfeb24000 if DEBUG_RK3X_UART0
 	default 0xfeb26000 if DEBUG_RK3X_UART1
 	default 0xfeb30c00 if DEBUG_KEYSTONE_UART0
-- 
1.9.1
