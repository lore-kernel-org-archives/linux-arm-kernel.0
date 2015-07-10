From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 14:04:28 +0900
Subject: [PATCH] ARM: EXYNOS: pmu: Drop owner assignment
In-Reply-To: <1436504668-1405-1-git-send-email-k.kozlowski@samsung.com>
References: <1436504668-1405-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1436504668-1405-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 arch/arm/mach-exynos/pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index e812c1c85624..960fc3510545 100644
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
1.9.1
