From: stefan@agner.ch (Stefan Agner)
Date: Wed, 18 Apr 2018 14:52:54 +0200
Subject: [PATCH] clk: imx6ul: fix periph clk2 clock mux selection
Message-ID: <20180418125254.4397-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the data sheet the 3rd choice is the bypass clock
of pll2. This should not have any effect in practice as this
selection is not used currently.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-imx6ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 12320118f8de..2ed7dae39008 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -40,7 +40,7 @@ static const char *axi_alt_sels[] = { "pll2_pfd2_396m", "pll3_pfd1_540m", };
 static const char *axi_sels[] = {"periph", "axi_alt_sel", };
 static const char *periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m", "pll2_pfd0_352m", "pll2_198m", };
 static const char *periph2_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m", "pll2_pfd0_352m", "pll4_audio_div", };
-static const char *periph_clk2_sels[] = { "pll3_usb_otg", "osc", "osc", };
+static const char *periph_clk2_sels[] = { "pll3_usb_otg", "osc", "pll2_bypass_src", };
 static const char *periph2_clk2_sels[] = { "pll3_usb_otg", "osc", };
 static const char *periph_sels[] = { "periph_pre", "periph_clk2", };
 static const char *periph2_sels[] = { "periph2_pre", "periph2_clk2", };
-- 
2.17.0
