From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 30 Sep 2014 12:17:59 +0200
Subject: [PATCH] ARM: rockchip: honor renaming of cpufreq-cpu0 to cpufreq-dt
In-Reply-To: <1712743.HcKV7iIeyP@phil>
References: <7172632.O1FfdvXn6k@phil> <201717175.L17Ccvmpek@phil>
 <1712743.HcKV7iIeyP@phil>
Message-ID: <3994184.eAcGc0TxgK@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpufreq-cpu0 got renamed to a more generic name cpufreq-dt, so
adapt the created platform-device to this.

Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This is for completenes sake, the patch I added to the cpufreqdev branch
as part of the pull request, handling the renamed cpufreq-cpu0 driver.


 arch/arm/mach-rockchip/rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index eea1f06..d226b71 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -27,7 +27,7 @@
 static void __init rockchip_dt_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_simple("cpufreq-cpu0", 0, NULL, 0);
+	platform_device_register_simple("cpufreq-dt", 0, NULL, 0);
 }
 
 static const char * const rockchip_board_dt_compat[] = {
-- 
2.1.0
