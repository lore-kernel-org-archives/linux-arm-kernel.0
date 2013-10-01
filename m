From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  1 Oct 2013 13:48:43 -0700
Subject: [PATCH] arm64: Remove duplicate DEBUG_STACK_USAGE config
Message-ID: <1380660523-19036-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This config item already exists generically in lib/Kconfig.debug.
Remove the duplicate config in arm64.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/Kconfig.debug | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 1a6bfe9..835c5597 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -6,13 +6,6 @@ config FRAME_POINTER
 	bool
 	default y
 
-config DEBUG_STACK_USAGE
-	bool "Enable stack utilization instrumentation"
-	depends on DEBUG_KERNEL
-	help
-	  Enables the display of the minimum amount of free stack which each
-	  task has ever had available in the sysrq-T output.
-
 config EARLY_PRINTK
 	bool "Early printk support"
 	default y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
