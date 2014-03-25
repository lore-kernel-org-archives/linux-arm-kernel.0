From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 25 Mar 2014 17:00:59 +0800
Subject: [PATCH] arm64: Fix duplicated Kconfig entries again
Message-ID: <1395738060-18489-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit 74397174989e5 (arm64: Fix duplicated Kconfig entries),
I still get a duplicate Power management options section in linux-next
git repo, may be due to some merge conflicts, anyway, fix that in this
patch.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
Based on linux-next repo, weird, did I miss something?
---
 arch/arm64/Kconfig |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d9f23ad..6085dca 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -317,24 +317,12 @@ config ARCH_SUSPEND_POSSIBLE
 config ARM64_CPU_SUSPEND
 	def_bool PM_SLEEP
 
-endmenu
-
-menu "CPU Power Management"
-
 source "drivers/cpuidle/Kconfig"
 
 source "drivers/cpufreq/Kconfig"
 
 endmenu
 
-menu "Power management options"
-
-source "kernel/power/Kconfig"
-
-source "drivers/cpufreq/Kconfig"
-
-endmenu
-
 source "net/Kconfig"
 
 source "drivers/Kconfig"
-- 
1.7.9.5
