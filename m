From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 16 Jan 2017 18:08:29 +0800
Subject: [PATCH v2 09/11] drm/rockchip/dsi: decrease the value of Ths-prepare
In-Reply-To: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
References: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1484561311-494-10-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: xubilv <xbl@rock-chips.com>

Signed-off-by: xubilv <xbl@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 4a2691c..f50909e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -455,7 +455,7 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 					 BANDGAP_SEL(BANDGAP_96_10));
 
 	dw_mipi_dsi_phy_write(dsi, 0x70, TLP_PROGRAM_EN | 0xf);
-	dw_mipi_dsi_phy_write(dsi, 0x71, THS_PRE_PROGRAM_EN | 0x55);
+	dw_mipi_dsi_phy_write(dsi, 0x71, THS_PRE_PROGRAM_EN | 0x2d);
 	dw_mipi_dsi_phy_write(dsi, 0x72, THS_ZERO_PROGRAM_EN | 0xa);
 
 	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
-- 
2.6.3
