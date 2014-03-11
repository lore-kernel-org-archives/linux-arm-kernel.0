From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Mar 2014 13:17:31 +0000
Subject: [PATCH] arm64: Fix duplicated Kconfig entries
Message-ID: <1394543851-11732-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Probably due to rebasing over the lengthy time it took to get the patch
merged commit addea9ef055b (cpufreq: enable ARM drivers on arm64) added
a duplicate Power management options section.  Add CPUfreq to the CPU
power management section and remove a duplicate include of the main
power section.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a3c40d65128b..2474c24dc229 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -318,12 +318,6 @@ menu "CPU Power Management"
 
 source "drivers/cpuidle/Kconfig"
 
-endmenu
-
-menu "Power management options"
-
-source "kernel/power/Kconfig"
-
 source "drivers/cpufreq/Kconfig"
 
 endmenu
-- 
1.9.0
