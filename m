From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:21 +0900
Subject: [PATCH 05/21] ARM: shmobile: Remove obsolete legacy PM Domain
 leftovers
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <edc77c65df148548bd168fde9607707d81de39ff.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The last users were removed in commit b587288001f05c0e ("ARM: shmobile:
R-Mobile: Remove legacy PM Domain code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rmobile.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.h b/arch/arm/mach-shmobile/pm-rmobile.h
index 30a4a421ee31..8146bb6d7237 100644
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
2.1.4
