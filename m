From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  7 Sep 2018 15:22:31 +0800
Subject: [PATCH 2/5] drm: sun4i: drop second PLL from A64 HDMI PHY
In-Reply-To: <20180907072234.48282-1-icenowy@aosc.io>
References: <20180907072234.48282-1-icenowy@aosc.io>
Message-ID: <20180907072234.48282-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 HDMI PHY seems to be not able to use the second video PLL as
clock parent in experiments.

Drop the support for the second PLL from A64 HDMI PHY driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
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
