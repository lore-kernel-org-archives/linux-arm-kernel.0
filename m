From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 May 2014 18:22:53 +0200
Subject: [PATCH 2/5] Documentation: dt-bindings: document the Armada 375 USB
 cluster binding
In-Reply-To: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
References: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1400257376-13251-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 375 comes with an USB2 host and device controller and an USB3
controller. The USB cluster control register allows to manage common
features of both USB controllers. This commit adds the Device Tree
binding documentation for this piece of hardware.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../bindings/phy/armada-375-usb-phy-cluster.txt      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt

diff --git a/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt b/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt
new file mode 100644
index 000000000000..9bd1502e1f33
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt
@@ -0,0 +1,20 @@
+Armada 375 USB cluster
+----------------------
+
+Armada 375 comes with an USB2 host and device controller and an USB3
+controller. The USB cluster control register allows to manage common
+features of both USB controllers.
+
+Required properties:
+
+- compatible: "marvell,armada-375-usb-cluster"
+- reg: Should contain usb cluster register location and length.
+- #phy-cells : from the generic phy bindings, must be 1. Possible
+values are 0 (USB2), 1 (USB3).
+
+Example:
+	usbcluster: usb-cluster at 18400 {
+		compatible = "marvell,armada-375-usb-cluster";
+		reg = <0x18400 0x4>;
+		#phy-cells = <1>
+	};
-- 
1.8.1.2
