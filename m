From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 May 2014 16:45:28 +0800
Subject: [PATCH 10/20] ARM: imx5: call mxc_timer_init_dt() on imx51
In-Reply-To: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
References: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1400575538-21136-11-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since i.MX51 supports DT only, it's more appropriate to call
mxc_timer_init_dt() than mxc_timer_init() to initialize timer.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 67f686e..972b24c 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -449,7 +449,7 @@ static void __init mx51_clocks_init(struct device_node *np)
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 166250000);
 
 	/* System timer */
-	mxc_timer_init(MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR), MX51_INT_GPT);
+	mxc_timer_init_dt(of_find_compatible_node(NULL, NULL, "fsl,imx51-gpt"));
 
 	clk_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
 	imx_print_silicon_rev("i.MX51", mx51_revision());
-- 
1.8.3.2
