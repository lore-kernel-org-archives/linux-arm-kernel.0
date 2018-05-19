From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 19 May 2018 20:31:25 +0200
Subject: [PATCH 13/15] drm/sun4i: Add support for A64 HDMI PHY
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Message-ID: <20180519183127.2718-14-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PHY is the same as in H3, except it can switch between two clock
parents.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 7a911f0a3ae3..0c9d67bb1007 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -396,6 +396,14 @@ static struct regmap_config sun8i_hdmi_phy_regmap_config = {
 	.name		= "phy"
 };
 
+static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
+	.has_phy_clk = true,
+	.has_second_pll = true,
+	.phy_init = &sun8i_hdmi_phy_init_h3,
+	.phy_disable = &sun8i_hdmi_phy_disable_h3,
+	.phy_config = &sun8i_hdmi_phy_config_h3,
+};
+
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
 	.phy_init = &sun8i_hdmi_phy_init_a83t,
 	.phy_disable = &sun8i_hdmi_phy_disable_a83t,
@@ -410,6 +418,10 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 };
 
 static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
+	{
+		.compatible = "allwinner,sun50i-a64-hdmi-phy",
+		.data = &sun50i_a64_hdmi_phy,
+	},
 	{
 		.compatible = "allwinner,sun8i-a83t-hdmi-phy",
 		.data = &sun8i_a83t_hdmi_phy,
-- 
2.17.0
