From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:28:06 +0200
Subject: [PATCH 16/33] ARM i.MX5: prepare gpc_dvfs_clk
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-17-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx5.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index e10f391..68341cf 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -32,6 +32,7 @@ static void imx5_idle(void)
 		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
 		if (IS_ERR(gpc_dvfs_clk))
 			return;
+		clk_prepare(gpc_dvfs_clk);
 	}
 	clk_enable(gpc_dvfs_clk);
 	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
-- 
1.7.10
