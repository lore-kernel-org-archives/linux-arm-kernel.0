From: hl@rock-chips.com (Lin Huang)
Date: Fri,  4 May 2018 16:08:57 +0800
Subject: [PATCH 3/4] Documentation: bindings: add phy_config for Rockchip USB
 Type-C PHY
In-Reply-To: <1525421338-1021-1-git-send-email-hl@rock-chips.com>
References: <1525421338-1021-1-git-send-email-hl@rock-chips.com>
Message-ID: <1525421338-1021-3-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If want to do training outside DP Firmware, need phy voltage swing
and pre_emphasis value.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
index 960da7f..eda26dd 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
@@ -17,7 +17,9 @@ Required properties:
 
 Optional properties:
  - extcon : extcon specifier for the Power Delivery
-
+ - rockchip,phy_config : That's phy voltage swing and pre_emphasis
+			 setting, if want to do dp training outside
+			 dp firmware, need to add these value.
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify dp or usb3 port,
 		 and shall be the following entries:
-- 
2.7.4
