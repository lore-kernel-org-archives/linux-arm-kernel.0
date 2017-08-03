From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu,  3 Aug 2017 16:09:12 +0800
Subject: [PATCH v3 4/5] dt-bindings: phy-rockchip-inno-usb2: add otg-mux
 interrupt
In-Reply-To: <1501747753-6983-1-git-send-email-frank.wang@rock-chips.com>
References: <1501747753-6983-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1501747753-6983-5-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add otg-mux property to support multiplexed interrupt in otg-port
on some Rockchip SoC (e.g RV1108).

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
index ddf868a..ed6aee4 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
@@ -32,10 +32,14 @@ Required nodes : a sub-node is required for each port the phy provides.
 Required properties (port (child) node):
  - #phy-cells : must be 0. See ./phy-bindings.txt for details.
  - interrupts : specify an interrupt for each entry in interrupt-names.
- - interrupt-names : a list which shall be the following entries:
+ - interrupt-names : a list which should be one of the following cases:
+	Regular case:
 	* "otg-id" : for the otg id interrupt.
 	* "otg-bvalid" : for the otg vbus interrupt.
 	* "linestate" : for the host/otg linestate interrupt.
+	Some SoCs use one interrupt with the obove muxed together, so for these
+	* "otg-mux" : otg-port interrupt, which mux otg-id/otg-bvalid/linestate
+		to one.
 
 Optional properties:
  - phy-supply : phandle to a regulator that provides power to VBUS.
-- 
2.0.0
