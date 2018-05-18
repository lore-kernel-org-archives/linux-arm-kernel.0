From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 18 May 2018 15:15:23 +0530
Subject: [PATCH v2 13/26] drm/sun4i: Add support for A64 HDMI PHY
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Message-ID: <20180518094536.17201-14-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

PHY is the same as in H3, except it can select between two clock parent.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 0eadf087fc46..39fbf7257fce 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -392,6 +392,13 @@ static struct regmap_config sun8i_hdmi_phy_regmap_config = {
 	.name		= "phy"
 };
 
+static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
+	.phy_clk_num = 2,
+	.phy_init = &sun8i_hdmi_phy_init_h3,
+	.phy_disable = &sun8i_hdmi_phy_disable_h3,
+	.phy_config = &sun8i_hdmi_phy_config_h3,
+};
+
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
 	.phy_init = &sun8i_hdmi_phy_init_a83t,
 	.phy_disable = &sun8i_hdmi_phy_disable_a83t,
@@ -406,6 +413,10 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
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
2.14.3
