From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:36:48 +0900
Subject: [PATCH 01/16] ARM: shmobile: R-Mobile: Move to_rmobile_pd from header
 to source file
In-Reply-To: <cover.1436509680.git.horms+renesas@verge.net.au>
References: <cover.1436509680.git.horms+renesas@verge.net.au>
Message-ID: <23758258220c2fcdabb30a3c6fe0a3ce6c705550.1436509680.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

to_rmobile_pd() is only used inside pm-rmobile.c

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 6 ++++++
 arch/arm/mach-shmobile/pm-rmobile.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 95018209ff0b..94161c9b1878 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -34,6 +34,12 @@
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
+static inline
+struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
+{
+	return container_of(d, struct rmobile_pm_domain, genpd);
+}
+
 static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
diff --git a/arch/arm/mach-shmobile/pm-rmobile.h b/arch/arm/mach-shmobile/pm-rmobile.h
index 53219786f539..3992b619c127 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.h
+++ b/arch/arm/mach-shmobile/pm-rmobile.h
@@ -26,12 +26,6 @@ struct rmobile_pm_domain {
 	bool no_debug;
 };
 
-static inline
-struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
-{
-	return container_of(d, struct rmobile_pm_domain, genpd);
-}
-
 struct pm_domain_device {
 	const char *domain_name;
 	struct platform_device *pdev;
-- 
2.1.4
