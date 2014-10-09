From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 09 Oct 2014 18:38:56 +0200
Subject: [PATCH 20/21] thermal: exynos: Make Exynos5250 TMU compatible with
 Exynos4412
In-Reply-To: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1412872737-624-21-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since both SoCs have the same TMU IP block embedded on them, it is
not necessary to maintain separate compatible entry.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi    | 2 +-
 drivers/thermal/samsung/exynos_tmu.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index e71ec78..3426bab 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -238,7 +238,7 @@
 	};
 
 	tmu: tmu at 10060000 {
-		compatible = "samsung,exynos5250-tmu";
+		compatible = "samsung,exynos4412-tmu";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 65 0>;
 		clocks = <&clock CLK_TMU>;
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index e26042a..f1e8c9b 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -753,9 +753,6 @@ static const struct of_device_id exynos_tmu_match[] = {
 		.compatible = "samsung,exynos4412-tmu",
 	},
 	{
-		.compatible = "samsung,exynos5250-tmu",
-	},
-	{
 		.compatible = "samsung,exynos5260-tmu",
 	},
 	{
-- 
2.0.0.rc2
