From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sat,  2 Apr 2016 01:00:32 -0300
Subject: [PATCH] ARM: Drop CONFIG_RTC_LIB dependency
Message-ID: <1459569633-6470-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rtc-lib dependency seems to be here for very old historical
reasons, but nowadays it shouldn't be needed. If any ARM
platform requires rtc-lib, they should select it individually.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2b7626..8efb1c605ac8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -84,7 +84,6 @@ config ARM
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select PERF_USE_VMALLOC
-	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
-- 
2.7.0
