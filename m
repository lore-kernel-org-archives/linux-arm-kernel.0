From: hl@rock-chips.com (Lin Huang)
Date: Thu, 17 May 2018 17:17:58 +0800
Subject: [PATCH v5 2/4] Documentation: bindings: add phy_config for Rockchip
 USB Type-C PHY
In-Reply-To: <1526548680-2552-1-git-send-email-hl@rock-chips.com>
References: <1526548680-2552-1-git-send-email-hl@rock-chips.com>
Message-ID: <1526548680-2552-2-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If want to do training outside DP Firmware, need phy voltage swing
and pre_emphasis value.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- None 
Changes in v3:
- modify property description and add this property to Example
Change in v4:
- None
Change in v5:
- None

 .../devicetree/bindings/phy/phy-rockchip-typec.txt | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
index 960da7f..af298f2 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
@@ -17,7 +17,8 @@ Required properties:
 
 Optional properties:
  - extcon : extcon specifier for the Power Delivery
-
+ - rockchip,phy_config : A list of voltage swing(mv) and pre-emphasis
+			(dB) pairs.
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify dp or usb3 port,
 		 and shall be the following entries:
@@ -50,6 +51,19 @@ Example:
 			 <&cru SRST_P_UPHY0_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 
+		rockchip,phy_config =<0x2a 0x00
+			0x1f 0x15
+			0x14 0x22
+			0x02 0x2b
+			0x21 0x00
+			0x12 0x15
+			0x02 0x22
+			0 0
+			0x15 0x00
+			0x00 0x15
+			0 0
+			0 0>;
+
 		tcphy0_dp: dp-port {
 			#phy-cells = <0>;
 		};
@@ -74,6 +88,19 @@ Example:
 			 <&cru SRST_P_UPHY1_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 
+		rockchip,phy_config =<0x2a 0x00
+			0x1f 0x15
+			0x14 0x22
+			0x02 0x2b
+			0x21 0x00
+			0x12 0x15
+			0x02 0x22
+			0 0
+			0x15 0x00
+			0x00 0x15
+			0 0
+			0 0>;
+
 		tcphy1_dp: dp-port {
 			#phy-cells = <0>;
 		};
-- 
2.7.4
