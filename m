From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Aug 2017 16:14:05 +0800
Subject: [PATCH 2/8] dt-bindings: phy: sun4i-usb-phy: Add compatible string
 for A83T
In-Reply-To: <20170803081411.22389-1-wens@csie.org>
References: <20170803081411.22389-1-wens@csie.org>
Message-ID: <20170803081411.22389-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has 3 USB PHYs, 1 for OTG, 1 for standard USB, 1 for USB HSIC.

Add a compatible string for it, and describe the needed properties.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index 893dd01dfe64..cbc7847dbf6c 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -9,6 +9,7 @@ Required properties:
   * allwinner,sun7i-a20-usb-phy
   * allwinner,sun8i-a23-usb-phy
   * allwinner,sun8i-a33-usb-phy
+  * allwinner,sun8i-a83t-usb-phy
   * allwinner,sun8i-h3-usb-phy
   * allwinner,sun8i-v3s-usb-phy
   * allwinner,sun50i-a64-usb-phy
@@ -17,7 +18,7 @@ Required properties:
   * "phy_ctrl"
   * "pmu0" for H3, V3s and A64
   * "pmu1"
-  * "pmu2" for sun4i, sun6i, sun7i or sun8i-h3
+  * "pmu2" for sun4i, sun6i, sun7i, sun8i-a83t or sun8i-h3
   * "pmu3" for sun8i-h3
 - #phy-cells : from the generic phy bindings, must be 1
 - clocks : phandle + clock specifier for the phy clocks
@@ -25,12 +26,13 @@ Required properties:
   * "usb_phy" for sun4i, sun5i or sun7i
   * "usb0_phy", "usb1_phy" and "usb2_phy" for sun6i
   * "usb0_phy", "usb1_phy" for sun8i
+  * "usb0_phy", "usb1_phy", "usb2_phy" and "usb2_hsic_12M" for sun8i-a83t
   * "usb0_phy", "usb1_phy", "usb2_phy" and "usb3_phy" for sun8i-h3
 - resets : a list of phandle + reset specifier pairs
 - reset-names :
   * "usb0_reset"
   * "usb1_reset"
-  * "usb2_reset" for sun4i, sun6i, sun7i or sun8i-h3
+  * "usb2_reset" for sun4i, sun6i, sun7i, sun8i-a83t or sun8i-h3
   * "usb3_reset" for sun8i-h3
 
 Optional properties:
-- 
2.13.3
