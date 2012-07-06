From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  6 Jul 2012 19:04:35 -0300
Subject: [PATCH] ARM: mx27: Reenable silicon version print
Message-ID: <1341612275-4464-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Prior to the new i.mx clock conversion the mx27 silicon version was printed at boot.

Reenable this feature.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx27.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index e8a6016..c9370bf 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -269,6 +269,8 @@ int __init mx27_clocks_init(unsigned long fref)
 
 	clk_prepare_enable(clk[emi_ahb_gate]);
 
+	imx_print_silicon_rev("i.MX27", mx27_revision());
+
 	return 0;
 }
 
-- 
1.7.1
