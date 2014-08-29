From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 29 Aug 2014 15:51:00 +0200
Subject: [PATCH 2/5] Documentation: bindings: net: add the Marvell Berlin
 Ethernet controller
In-Reply-To: <1409320263-10295-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1409320263-10295-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1409320263-10295-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the binding documentation for the Marvell Berlin Ethernet
controller.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/net/marvell-berlin.txt     | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell-berlin.txt

diff --git a/Documentation/devicetree/bindings/net/marvell-berlin.txt b/Documentation/devicetree/bindings/net/marvell-berlin.txt
new file mode 100644
index 000000000000..0ae468aef13f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell-berlin.txt
@@ -0,0 +1,23 @@
+* Marvell Berlin Ethernet Controller
+
+Required properties:
+- compatible: should be "marvell,berlin-eth".
+- reg: address and length of the register set for the device.
+- interrupts: interrupt for the device.
+- phy-handle: pointer to the Ethernet PHY.
+- clocks: pointer to the clock for the device.
+
+Optional properties:
+- local-mac-address: see ethernet.txt file in the same directory.
+
+
+Example:
+
+	eth0: ethernet at f7b90000 {
+		compatible = "marvell,berlin-eth";
+        	reg = <0xf7b90000 0x10000>;
+		clocks = <&chip CLKID_GETH0>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		phy-handle = <&ethphy0>;
+		local-mac-address = [00 00 00 00 00 00];
+	};
-- 
1.9.1
