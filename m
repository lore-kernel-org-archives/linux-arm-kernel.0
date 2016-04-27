From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 27 Apr 2016 13:55:28 -0300
Subject: [PATCH] arm64: Drop CONFIG_RTC_LIB dependency
Message-ID: <1461776128-7808-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rtc-lib dependency is not required, and seems it was just
copy-pasted from ARM's Kconfig. If platform requires rtc-lib,
they should select it individually.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c8762f4613f0..b9d0a81d391c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -99,7 +99,6 @@ config ARM64
 	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
-	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	help
-- 
2.7.0
