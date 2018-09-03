From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  3 Sep 2018 21:34:33 +0800
Subject: [PATCH 2/3] drm/sun4i: change A64 HDMI PHY binding to R40
In-Reply-To: <20180903133434.58188-1-icenowy@aosc.io>
References: <20180903133434.58188-1-icenowy@aosc.io>
Message-ID: <20180903133434.58188-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A64 SoC is proven to have no PLL-VIDEO mux in the HDMI PHY
clock, although it has two PLL-VIDEOs. The R40 SoC has this mux.

Change the binding compatible string from sun50i-a64 to sun8i-r40, and
let A64 to use H3 compatible string.

The compatible string is introduced in v4.19, and during the RC stage we
can still change it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 82502b351aec..744a8a2a15c0 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -396,7 +396,7 @@ static struct regmap_config sun8i_hdmi_phy_regmap_config = {
 	.name		= "phy"
 };
 
-static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
+static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy = {
 	.has_phy_clk = true,
 	.has_second_pll = true,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
@@ -419,8 +419,8 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 
 static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 	{
-		.compatible = "allwinner,sun50i-a64-hdmi-phy",
-		.data = &sun50i_a64_hdmi_phy,
+		.compatible = "allwinner,sun8i-r40-hdmi-phy",
+		.data = &sun8i_r40_hdmi_phy,
 	},
 	{
 		.compatible = "allwinner,sun8i-a83t-hdmi-phy",
-- 
2.18.0
