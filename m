From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Mon, 23 Sep 2013 20:14:59 -0700
Subject: [PATCH 1/3] ARM: debug: Create CONFIG_DEBUG_MSM_UART and re-organize
 the selects for MSM
Message-ID: <1379992499-3662-1-git-send-email-rvaswani@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create the hidden config DEBUG_MSM_UART and clean-up the default selection
for CONFIG_DEBUG_LL_INCLUDE.

Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
---
 arch/arm/Kconfig.debug | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9762c84..e18a6fc 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -318,6 +318,7 @@ choice
 	config DEBUG_MSM_UART1
 		bool "Kernel low-level debugging messages via MSM UART1"
 		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
+		select DEBUG_MSM_UART
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the first serial port on MSM devices.
@@ -325,6 +326,7 @@ choice
 	config DEBUG_MSM_UART2
 		bool "Kernel low-level debugging messages via MSM UART2"
 		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
+		select DEBUG_MSM_UART
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on MSM devices.
@@ -332,6 +334,7 @@ choice
 	config DEBUG_MSM_UART3
 		bool "Kernel low-level debugging messages via MSM UART3"
 		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
+		select DEBUG_MSM_UART
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the third serial port on MSM devices.
@@ -340,6 +343,7 @@ choice
 		bool "Kernel low-level debugging messages via MSM 8660 UART"
 		depends on ARCH_MSM8X60
 		select MSM_HAS_DEBUG_UART_HS
+		select DEBUG_MSM_UART
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port on MSM 8660 devices.
@@ -348,6 +352,7 @@ choice
 		bool "Kernel low-level debugging messages via MSM 8960 UART"
 		depends on ARCH_MSM8960
 		select MSM_HAS_DEBUG_UART_HS
+		select DEBUG_MSM_UART
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port on MSM 8960 devices.
@@ -880,6 +885,10 @@ config DEBUG_STI_UART
 	bool
 	depends on ARCH_STI
 
+config DEBUG_MSM_UART
+	bool
+	depends on ARCH_MSM
+
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
@@ -895,11 +904,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX53_UART ||\
 				 DEBUG_IMX6Q_UART || \
 				 DEBUG_IMX6SL_UART
-	default "debug/msm.S" if DEBUG_MSM_UART1 || \
-				 DEBUG_MSM_UART2 || \
-				 DEBUG_MSM_UART3 || \
-				 DEBUG_MSM8660_UART || \
-				 DEBUG_MSM8960_UART
+	default "debug/msm.S" if DEBUG_MSM_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
 	default "debug/sti.S" if DEBUG_STI_UART
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
