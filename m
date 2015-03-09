From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 Mar 2015 11:51:49 +0800
Subject: [PATCH v2.0 6/6] pm: at91: remove unused void (*at91_pm_standby)(void)
In-Reply-To: <1425872857-7772-1-git-send-email-wenyou.yang@atmel.com>
References: <1425872857-7772-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1425873109-8025-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the standby mode use the same sram function as the suspend to memory
mode, void (*at91_pm_standby)(void) doesn't need, remove it.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index a008e9c..9fb868d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -42,7 +42,6 @@ static struct {
 	int memctrl;
 } at91_pm_data;
 
-static void (*at91_pm_standby)(void);
 void __iomem *at91_ramc_base[2];
 
 static int at91_pm_valid_state(suspend_state_t state)
@@ -207,10 +206,8 @@ static struct platform_device at91_cpuidle_device = {
 
 static void at91_pm_set_standby(void (*at91_standby)(void))
 {
-	if (at91_standby) {
+	if (at91_standby)
 		at91_cpuidle_device.dev.platform_data = at91_standby;
-		at91_pm_standby = at91_standby;
-	}
 }
 
 static const struct of_device_id ramc_ids[] __initconst = {
-- 
1.7.9.5
