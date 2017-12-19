From: martin@kaiser.cx (Martin Kaiser)
Date: Tue, 19 Dec 2017 11:07:04 +0100
Subject: [PATCH] ARM: imx: remove unused imx3 pm definitions
Message-ID: <1513678024-2779-1-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the defintion of mx3_cpu_lp_set(), this function is not
implemented anywhere. Remove then mx3_cpu_pwr_mode enum as well,
it was used only as parameter of mx3_cpu_lp_set().

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/mach-imx/common.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index b09a2ec..c8d68e9 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -71,15 +71,6 @@ enum mxc_cpu_pwr_mode {
 	STOP_POWER_OFF,		/* STOP + SRPG */
 };
 
-enum mx3_cpu_pwr_mode {
-	MX3_RUN,
-	MX3_WAIT,
-	MX3_DOZE,
-	MX3_SLEEP,
-};
-
-void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
-
 void imx_enable_cpu(int cpu, bool enable);
 void imx_set_cpu_jump(int cpu, void *jump_addr);
 u32 imx_get_cpu_arg(int cpu);
-- 
2.1.4
