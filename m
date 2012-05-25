From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 25 May 2012 20:14:42 -0300
Subject: [PATCH 01/15] ARM: mx5: Use clk_prepare_enable/clk_disable_unprepare
Message-ID: <1337987696-31728-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Prepare the clock before enabling it.

Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx5.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index feeee17..fcad95c 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -35,11 +35,11 @@ static void imx5_idle(void)
 			return;
 		clk_prepare(gpc_dvfs_clk);
 	}
-	clk_enable(gpc_dvfs_clk);
+	clk_prepare_enable(gpc_dvfs_clk);
 	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
 	if (!tzic_enable_wake())
 		cpu_do_idle();
-	clk_disable(gpc_dvfs_clk);
+	clk_disable_unprepare(gpc_dvfs_clk);
 }
 
 /*
-- 
1.7.1
