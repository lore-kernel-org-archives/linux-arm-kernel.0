From: b20788@freescale.com (Anson Huang)
Date: Wed, 17 Dec 2014 12:23:19 +0800
Subject: [PATCH V2] ARM: imx: remove unnecessary setting for DSM
Message-ID: <1418790199-12919-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we support DSM in OCRAM for all i.MX6 SoCs,
the resume entry point is set in asm code of
suspend-imx6.S, so no need to set the resume
entry point for SRC in pre-suspend flow.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/pm-imx6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index c653dd4..671e2a9 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -363,7 +363,6 @@ static int imx6q_pm_enter(suspend_state_t state)
 			imx6q_enable_rbc(true);
 		imx_gpc_pre_suspend(true);
 		imx_anatop_pre_suspend();
-		imx_set_cpu_jump(0, v7_cpu_resume);
 		/* Zzz ... */
 		cpu_suspend(0, imx6q_suspend_finish);
 		if (cpu_is_imx6q() || cpu_is_imx6dl())
-- 
1.9.1
