From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 18 Jun 2013 13:08:56 +0400
Subject: [PATCH] ARM: i.MX: Register clock i.MX5x wire1 device
Message-ID: <1371546536-19386-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 9afac26..7da8f0d 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -339,6 +339,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[epit1_hf_gate], "per", "imx-epit.0");
 	clk_register_clkdev(clk[epit2_ipg_gate], "ipg", "imx-epit.1");
 	clk_register_clkdev(clk[epit2_hf_gate], "per", "imx-epit.1");
+	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1.0");
 
 	/* Set SDHC parents to be PLL2 */
 	clk_set_parent(clk[esdhc_a_sel], clk[pll2_sw]);
-- 
1.8.1.5
