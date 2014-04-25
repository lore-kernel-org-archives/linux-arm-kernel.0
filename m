From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Apr 2014 16:07:11 +0200
Subject: [PATCH v2 13/18] dt: binding: Armada 375 USB cluster
In-Reply-To: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1398434836-18908-14-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 375 comes with an USB2 host and device controller and an USB3
controller. The USB cluster control register allows to manage common
features of both USB controllers.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-375-usb-cluster.txt  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-375-usb-cluster.txt

diff --git a/Documentation/devicetree/bindings/arm/armada-375-usb-cluster.txt b/Documentation/devicetree/bindings/arm/armada-375-usb-cluster.txt
new file mode 100644
index 000000000000..71feb8fb4434
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-375-usb-cluster.txt
@@ -0,0 +1,17 @@
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
+
+Example:
+	usb-cluster at 18400 {
+		compatible = "marvell,armada-375-usb-cluster";
+		reg = <0x18400 0x4>;
+	};
-- 
1.8.1.2
