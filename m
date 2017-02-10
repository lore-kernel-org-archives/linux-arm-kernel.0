From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 10 Feb 2017 15:44:11 +0800
Subject: [PATCH 1/4] Documentation: bindings: add uphy-dp-sel for Rockchip USB
 Type-C PHY
In-Reply-To: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1486712654-15431-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip,uphy-dp-sel is the register of type-c phy enable DP function.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
index 6ea867e..c3be83b 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
@@ -33,6 +33,9 @@ offset, enable bit, write mask bit.
  - rockchip,pipe-status : the register of type-c phy pipe status.
    for type-c phy0, it must be <0xe5c0 0 0>;
    for type-c phy1, it must be <0xe5c0 16 16>;
+ - rockchip,uphy-dp-sel : the register of type-c phy enable DP function
+   for type-c phy0, it must be <0x6268 19 19>;
+   for type-c phy1, it must be <0x6268 3 19>;
 
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify dp or usb3 port,
@@ -62,6 +65,7 @@ Example:
 		rockchip,usb3tousb2-en = <0xe580 3 19>;
 		rockchip,external-psm = <0xe588 14 30>;
 		rockchip,pipe-status = <0xe5c0 0 0>;
+		rockchip,uphy-dp-sel = <0x6268 19 19>;
 
 		tcphy0_dp: dp-port {
 			#phy-cells = <0>;
@@ -90,6 +94,7 @@ Example:
 		rockchip,usb3tousb2-en = <0xe58c 3 19>;
 		rockchip,external-psm = <0xe594 14 30>;
 		rockchip,pipe-status = <0xe5c0 16 16>;
+		rockchip,uphy-dp-sel = <0x6268 3 19>;
 
 		tcphy1_dp: dp-port {
 			#phy-cells = <0>;
-- 
2.6.3
