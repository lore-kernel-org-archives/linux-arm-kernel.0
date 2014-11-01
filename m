From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat,  1 Nov 2014 15:41:38 +0100
Subject: [PATCH v2] ARM: BCM5301X: set customized AUXCTL
In-Reply-To: <1414851912-30630-1-git-send-email-hauke@hauke-m.de>
References: <1414851912-30630-1-git-send-email-hauke@hauke-m.de>
Message-ID: <1414852899-30947-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This activates some more features in the l310 cache.

This is based on some vendor code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/mach-bcm/bcm_5301x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

changes
v1:
 - fix the commit message.

diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index e9bcbdb..8433a7c 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -49,7 +49,10 @@ static const char __initconst *bcm5301x_dt_compat[] = {
 };
 
 DT_MACHINE_START(BCM5301X, "BCM5301X")
-	.l2c_aux_val	= 0,
+	.l2c_aux_val	= L310_AUX_CTRL_CACHE_REPLACE_RR |
+			  L310_AUX_CTRL_DATA_PREFETCH |
+			  L310_AUX_CTRL_INSTR_PREFETCH |
+			  L310_AUX_CTRL_EARLY_BRESP,
 	.l2c_aux_mask	= ~0,
 	.init_early	= bcm5301x_init_early,
 	.dt_compat	= bcm5301x_dt_compat,
-- 
1.9.1
