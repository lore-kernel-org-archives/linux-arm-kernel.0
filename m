From: chihau@gmail.com (Chihau Chau)
Date: Thu,  7 Apr 2011 19:06:33 -0300
Subject: [PATCH] arm: mach-msm: acpuclock-arm11: Using __func__ instead
	__FUNCTION__
Message-ID: <1302213993-32737-1-git-send-email-chihau@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changing the __FUNCTION__ variable for the C99 standard __func__

Signed-off-by: Chihau Chau <chihau@gmail.com>
---
 arch/arm/mach-msm/acpuclock-arm11.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/acpuclock-arm11.c b/arch/arm/mach-msm/acpuclock-arm11.c
index d716cf1..18ba209 100644
--- a/arch/arm/mach-msm/acpuclock-arm11.c
+++ b/arch/arm/mach-msm/acpuclock-arm11.c
@@ -379,7 +379,7 @@ int acpuclk_set_rate(unsigned long rate, int for_power_collapse)
 		}
 #if PERF_SWITCH_STEP_DEBUG
 		printk(KERN_DEBUG "%s: STEP khz = %u, pll = %d\n",
-			__FUNCTION__, cur_s->a11clk_khz, cur_s->pll);
+			__func__, cur_s->a11clk_khz, cur_s->pll);
 #endif
 		if (!for_power_collapse && cur_s->pll != ACPU_PLL_TCXO
 		    && !(plls_enabled & (1 << cur_s->pll))) {
@@ -428,7 +428,7 @@ int acpuclk_set_rate(unsigned long rate, int for_power_collapse)
 	}
 
 #if PERF_SWITCH_DEBUG
-	printk(KERN_DEBUG "%s: ACPU speed change complete\n", __FUNCTION__);
+	printk(KERN_DEBUG "%s: ACPU speed change complete\n", __func__);
 #endif
 out:
 	if (!for_power_collapse)
-- 
1.7.3.4
