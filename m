From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  5 Sep 2014 15:51:56 -0700
Subject: [PATCH] ARM: debug: Update MSM and QCOM DEBUG_LL help
Message-ID: <1409957516-25616-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add another SoC address for apq8064 and use DEBUG_UART_VIRT
instead of DEBUG_UART_BASE because the former actually exists.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/Kconfig.debug | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 537dd04209bc..a71558ecf9da 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -378,7 +378,7 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port on MSM devices.
 
-		  ARCH                DEBUG_UART_PHYS   DEBUG_UART_BASE   #
+		  ARCH                DEBUG_UART_PHYS   DEBUG_UART_VIRT   #
 		  MSM7X00A, QSD8X50   0xa9a00000        0xe1000000        UART1
 		  MSM7X00A, QSD8X50   0xa9b00000        0xe1000000        UART2
 		  MSM7X00A, QSD8X50   0xa9c00000        0xe1000000        UART3
@@ -397,7 +397,8 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port on Qualcomm devices.
 
-		  ARCH      DEBUG_UART_PHYS   DEBUG_UART_BASE
+		  ARCH      DEBUG_UART_PHYS   DEBUG_UART_VIRT
+		  APQ8064   0x16640000        0xf0040000
 		  APQ8084   0xf995e000        0xfa75e000
 		  MSM8X60   0x19c40000        0xf0040000
 		  MSM8960   0x16440000        0xf0040000
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
