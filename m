From: broonie@kernel.org (Mark Brown)
Date: Sun,  6 Oct 2013 11:45:29 +0100
Subject: [PATCH] cpufreq: sa11x0: Fix build
Message-ID: <1381056329-3382-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Commit 22c8b4f140 (cpufreq: sa11x0: Expose frequency table) added use of
struct cpufreq_frequency_table to mach-sa1100/generic.h but did not ensure
that the struct was declared, causing build failures on machines using that
header. Fix this.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Mark Brown <broonie@linaro.org>
---

The relevant commit is in the cpufreq tree in -next.

 arch/arm/mach-sa1100/generic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index f5214ce..eff1469 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -4,6 +4,7 @@
  * Author: Nicolas Pitre
  */
 #include <linux/reboot.h>
+#include <linux/cpufreq.h>
 
 extern void sa1100_timer_init(void);
 extern void __init sa1100_map_io(void);
-- 
1.8.4.rc3
