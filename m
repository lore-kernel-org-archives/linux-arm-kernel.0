From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Oct 2014 17:24:11 +0200
Subject: [PATCH v2 3/6] Phy: DT binding documentation for the Armada 375 USB
 cluster binding
In-Reply-To: <1414164254-13053-1-git-send-email-gregory.clement@free-electrons.com>
References: <1414164254-13053-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1414164254-13053-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 375 comes with an USB2 host and device controller and an USB3
controller. The USB cluster control register allows to manage common
features of both USB controllers. This commit adds the Device Tree
binding documentation for this piece of hardware.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/phy/phy-mvebu.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu.txt b/Documentation/devicetree/bindings/phy/phy-mvebu.txt
index 6cb3364aeafb..f95b6260a3b3 100644
--- a/Documentation/devicetree/bindings/phy/phy-mvebu.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu.txt
@@ -20,3 +20,24 @@ Example:
 			#phy-cells = <0>;
 			status = "ok";
 		};
+
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
+values are 1 (USB2), 2 (USB3).
+
+Example:
+		usbcluster: usb-cluster at 18400 {
+			compatible = "marvell,armada-375-usb-cluster";
+			reg = <0x18400 0x4>;
+			#phy-cells = <1>
+		};
-- 
1.9.1
