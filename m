From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 16 Sep 2018 12:34:08 +0800
Subject: [PATCH v2 3/4] drm/sun4i: add support for R40 HDMI PHY
In-Reply-To: <20180916043409.62374-1-icenowy@aosc.io>
References: <20180916043409.62374-1-icenowy@aosc.io>
Message-ID: <20180916043409.62374-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R40 SoC has a HDMI PHY that is possible to mux two video PLLs.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- none.

 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index a564b5dfe082..471993097ced 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -416,6 +416,14 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 	.phy_config = &sun8i_hdmi_phy_config_h3,
 };
 
+static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy = {
+	.has_phy_clk = true,
+	.has_second_pll = true,
+	.phy_init = &sun8i_hdmi_phy_init_h3,
+	.phy_disable = &sun8i_hdmi_phy_disable_h3,
+	.phy_config = &sun8i_hdmi_phy_config_h3,
+};
+
 static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 	{
 		.compatible = "allwinner,sun50i-a64-hdmi-phy",
@@ -429,6 +437,10 @@ static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 		.compatible = "allwinner,sun8i-h3-hdmi-phy",
 		.data = &sun8i_h3_hdmi_phy,
 	},
+	{
+		.compatible = "allwinner,sun8i-r40-hdmi-phy",
+		.data = &sun8i_r40_hdmi_phy,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.18.0
