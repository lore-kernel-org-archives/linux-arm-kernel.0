From: john@metanate.com (John Keeping)
Date: Sat, 21 Jan 2017 16:31:19 +0000
Subject: [PATCH v2 17/26] drm/rockchip: dw-mipi-dsi: don't enable PHY PLL
 until it's configured
In-Reply-To: <20170121163128.22240-1-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
Message-ID: <20170121163128.22240-18-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: John Keeping <john@metanate.com>
---
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index ce1e6f9a2041..cfe7e4ba305c 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -413,12 +413,12 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 
 	dw_mipi_dsi_phy_write(dsi, 0x44, HSFREQRANGE_SEL(testdin));
 
-	dw_mipi_dsi_phy_write(dsi, 0x19, PLL_LOOP_DIV_EN | PLL_INPUT_DIV_EN);
 	dw_mipi_dsi_phy_write(dsi, 0x17, INPUT_DIVIDER(dsi->input_div));
 	dw_mipi_dsi_phy_write(dsi, 0x18, LOOP_DIV_LOW_SEL(dsi->feedback_div) |
 					 LOW_PROGRAM_EN);
 	dw_mipi_dsi_phy_write(dsi, 0x18, LOOP_DIV_HIGH_SEL(dsi->feedback_div) |
 					 HIGH_PROGRAM_EN);
+	dw_mipi_dsi_phy_write(dsi, 0x19, PLL_LOOP_DIV_EN | PLL_INPUT_DIV_EN);
 
 	dw_mipi_dsi_phy_write(dsi, 0x22, LOW_PROGRAM_EN |
 					 BIASEXTR_SEL(BIASEXTR_127_7));
-- 
2.11.0.197.gb556de5.dirty
