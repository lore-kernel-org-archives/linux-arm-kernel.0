From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:30 +0200
Subject: [PATCH 17/40] ARM i.MX5: prepare gpc_dvfs_clk
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-18-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx5.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 05250ae..d9936ce 100644
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
1.7.9.5
