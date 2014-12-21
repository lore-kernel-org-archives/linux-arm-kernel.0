From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Dec 2014 22:14:22 +0100
Subject: [PATCH 01/28] ARM: mach-exynos: drop owner assignment from
 platform_drivers
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1419196495-9626-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 arch/arm/mach-exynos/pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index c15761ca2f18..f629d2df66b0 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -991,7 +991,6 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 static struct platform_driver exynos_pmu_driver = {
 	.driver  = {
 		.name   = "exynos-pmu",
-		.owner	= THIS_MODULE,
 		.of_match_table = exynos_pmu_of_device_ids,
 	},
 	.probe = exynos_pmu_probe,
-- 
2.1.3
