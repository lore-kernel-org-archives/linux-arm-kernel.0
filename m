From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Thu, 21 Apr 2016 17:01:05 +0800
Subject: [PATCH v2] cpufreq: rockchip: Use generic platdev driver
In-Reply-To: <1461225849-36866-1-git-send-email-finley.xiao@rock-chips.com>
References: <1461225849-36866-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1461229265-53750-1-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

This patch add rockchip's compatible string to the compat list and
remove similar code from platform code for supporting generic platdev
driver.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
v1->v2:
- add a blank line before rockchip's compatible

 arch/arm/mach-rockchip/rockchip.c    |  1 -
 drivers/cpufreq/cpufreq-dt-platdev.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 3f07cc5..beb71da 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -74,7 +74,6 @@ static void __init rockchip_dt_init(void)
 {
 	rockchip_suspend_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_simple("cpufreq-dt", 0, NULL, 0);
 }
 
 static const char * const rockchip_board_dt_compat[] = {
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index f2ae7ad..fc6529b 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -21,6 +21,17 @@ static const struct of_device_id machines[] = {
 	{ .compatible = "samsung,exynos5420", },
 	{ .compatible = "samsung,exynos5800", },
 #endif
+
+	{ .compatible = "rockchip,rk2928", },
+	{ .compatible = "rockchip,rk3036", },
+	{ .compatible = "rockchip,rk3066a", },
+	{ .compatible = "rockchip,rk3066b", },
+	{ .compatible = "rockchip,rk3188", },
+	{ .compatible = "rockchip,rk3228", },
+	{ .compatible = "rockchip,rk3288", },
+	{ .compatible = "rockchip,rk3366", },
+	{ .compatible = "rockchip,rk3368", },
+	{ .compatible = "rockchip,rk3399", },
 };
 
 static int __init cpufreq_dt_platdev_init(void)
-- 
1.9.1
