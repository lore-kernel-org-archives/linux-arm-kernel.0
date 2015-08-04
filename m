From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Aug 2015 20:03:10 +0200
Subject: [PATCH 5/7] ARM: shmobile: Remove obsolete legacy PM Domain leftovers
In-Reply-To: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
References: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1438711392-23763-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last users were removed in commit b587288001f05c0e ("ARM: shmobile:
R-Mobile: Remove legacy PM Domain code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rmobile.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.h b/arch/arm/mach-shmobile/pm-rmobile.h
index 30a4a421ee315b98..8146bb6d7237eafc 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.h
+++ b/arch/arm/mach-shmobile/pm-rmobile.h
@@ -12,10 +12,6 @@
 
 #include <linux/pm_domain.h>
 
-#define DEFAULT_DEV_LATENCY_NS	250000
-
-struct platform_device;
-
 struct rmobile_pm_domain {
 	struct generic_pm_domain genpd;
 	struct dev_power_governor *gov;
@@ -26,9 +22,4 @@ struct rmobile_pm_domain {
 	bool no_debug;
 };
 
-struct pm_domain_device {
-	const char *domain_name;
-	struct platform_device *pdev;
-};
-
 #endif /* PM_RMOBILE_H */
-- 
1.9.1
