From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 16 Sep 2018 12:34:06 +0800
Subject: [PATCH v2 1/4] drm: sun4i: drop second PLL from A64 HDMI PHY
In-Reply-To: <20180916043409.62374-1-icenowy@aosc.io>
References: <20180916043409.62374-1-icenowy@aosc.io>
Message-ID: <20180916043409.62374-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 HDMI PHY seems to be not able to use the second video PLL as
clock parent in experiments.

Drop the support for the second PLL from A64 HDMI PHY driver.

Fixes: b46e2c9f5f64 ("drm/sun4i: Add support for A64 HDMI PHY")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- none.

 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 82502b351aec..a564b5dfe082 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -398,7 +398,6 @@ static struct regmap_config sun8i_hdmi_phy_regmap_config = {
 
 static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
 	.has_phy_clk = true,
-	.has_second_pll = true,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
 	.phy_disable = &sun8i_hdmi_phy_disable_h3,
 	.phy_config = &sun8i_hdmi_phy_config_h3,
-- 
2.18.0
