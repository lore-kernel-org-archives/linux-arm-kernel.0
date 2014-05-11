From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 11 May 2014 20:17:59 +0200
Subject: [PATCHv5 11/20] Documentation: dt-bindings: document the Armada 375
 USB cluster binding
In-Reply-To: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399832288-19899-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Armada 375 comes with an USB2 host and device controller and an USB3
controller. The USB cluster control register allows to manage common
features of both USB controllers. This commit adds the Device Tree
binding documentation for this piece of hardware.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/phy/armada-375-usb-phy-cluster.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt

diff --git a/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt b/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt
new file mode 100644
index 0000000..258407c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt
@@ -0,0 +1,19 @@
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
+- #phy-cells : from the generic phy bindings, must be 1
+
+Example:
+	usbcluster: usb-cluster at 18400 {
+		compatible = "marvell,armada-375-usb-cluster";
+		reg = <0x18400 0x4>;
+		#phy-cells = <1>
+	};
-- 
1.9.2
