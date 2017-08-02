From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed,  2 Aug 2017 15:53:09 +0800
Subject: [PATCH v2 4/5] dt-bindings: phy-rockchip-inno-usb2: add otg mux irq
 quirk
In-Reply-To: <1501660390-5956-1-git-send-email-frank.wang@rock-chips.com>
References: <1501660390-5956-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1501660390-5956-5-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rockchip,otg_mux_irq_quirk property to support the otg-id/
otg-bvalid/linestate irqs that are multiplexed to one irq in
otg-port on some special Rockchip SoCs (e.g RV1108).

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
index ddf868a..d49572b 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
@@ -22,6 +22,8 @@ Optional properties:
 		 register files".
  - rockchip,companion_grf_quirk : when set driver will request
 		 "rockchip,usbgrf" phandle as one companion-grf.
+ - rockchip,otg_mux_irq_quirk: set if otg-id/otg-bvalid/linestate irqs
+		 are multiplexed to one irq in otg-port on some SoCs.
 
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify host or otg port,
@@ -36,6 +38,9 @@ Required properties (port (child) node):
 	* "otg-id" : for the otg id interrupt.
 	* "otg-bvalid" : for the otg vbus interrupt.
 	* "linestate" : for the host/otg linestate interrupt.
+	* "otg-mux" : otg-port interrupt, which multiplex otg-id/otg-bvalid/
+		linestate irqs to one irq. Should specify if
+		rockchip,otg_mux_irq_quirk property is set.
 
 Optional properties:
  - phy-supply : phandle to a regulator that provides power to VBUS.
-- 
2.0.0
