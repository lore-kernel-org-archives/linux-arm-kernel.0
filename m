From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 17 Dec 2012 12:55:47 -0200
Subject: [PATCH] ARM: mach-imx6q: Do not run error code path in success case
Message-ID: <1355756147-24856-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'put_clk' path should only run in the case of failure, so provide a 'return'
to avoid it running in the success case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 4eb1b3a..61f50aa 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -134,6 +134,8 @@ static void __init imx6q_sabrelite_cko1_setup(void)
 	clk_set_parent(cko1_sel, ahb);
 	rate = clk_round_rate(cko1, 16000000);
 	clk_set_rate(cko1, rate);
+
+	return;
 put_clk:
 	if (!IS_ERR(cko1_sel))
 		clk_put(cko1_sel);
-- 
1.7.9.5
