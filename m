From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Oct 2012 10:01:57 +0200
Subject: [PATCH 1/3] ARM i.MX25: Fix lcdc_ipg_per parent clock
In-Reply-To: <1349856119-22363-1-git-send-email-s.hauer@pengutronix.de>
References: <1349856119-22363-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1349856119-22363-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's per7, not per6.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx25.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index d20d479..334c839 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -127,7 +127,7 @@ int __init mx25_clocks_init(void)
 	clk[esdhc2_ipg_per] = imx_clk_gate("esdhc2_ipg_per", "per4", ccm(CCM_CGCR0),  4);
 	clk[gpt_ipg_per] = imx_clk_gate("gpt_ipg_per", "per5", ccm(CCM_CGCR0),  5);
 	clk[i2c_ipg_per] = imx_clk_gate("i2c_ipg_per", "per6", ccm(CCM_CGCR0),  6);
-	clk[lcdc_ipg_per] = imx_clk_gate("lcdc_ipg_per", "per8", ccm(CCM_CGCR0),  7);
+	clk[lcdc_ipg_per] = imx_clk_gate("lcdc_ipg_per", "per7", ccm(CCM_CGCR0),  7);
 	clk[nfc_ipg_per] = imx_clk_gate("nfc_ipg_per", "ipg_per", ccm(CCM_CGCR0),  8);
 	clk[ssi1_ipg_per] = imx_clk_gate("ssi1_ipg_per", "per13", ccm(CCM_CGCR0), 13);
 	clk[ssi2_ipg_per] = imx_clk_gate("ssi2_ipg_per", "per14", ccm(CCM_CGCR0), 14);
-- 
1.7.10.4
