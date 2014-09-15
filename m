From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 15 Sep 2014 16:01:47 +0200
Subject: [PATCH v3 3/9] Documentation: bindings: net: add the Marvell PXA168
 Ethernet controller
In-Reply-To: <1410789713-15341-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1410789713-15341-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1410789713-15341-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the binding documentation for the Marvell PXA168 Ethernet
controller, following its DT support.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/net/marvell-pxa168.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell-pxa168.txt

diff --git a/Documentation/devicetree/bindings/net/marvell-pxa168.txt b/Documentation/devicetree/bindings/net/marvell-pxa168.txt
new file mode 100644
index 000000000000..4177abf3dac3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell-pxa168.txt
@@ -0,0 +1,21 @@
+* Marvell PXA168 Ethernet Controller
+
+Required properties:
+- compatible: should be "marvell,pxa168-eth".
+- reg: address and length of the register set for the device.
+- interrupts: interrupt for the device.
+- clocks: pointer to the clock for the device.
+
+Optional properties:
+- port-id: should be '0','1' or '2'.
+- phy-addr: MDIO address of the PHY.
+- local-mac-address: see ethernet.txt file in the same directory.
+
+Example:
+
+	eth0: ethernet at f7b90000 {
+		compatible = "marvell,pxa168-eth";
+		reg = <0xf7b90000 0x10000>;
+		clocks = <&chip CLKID_GETH0>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.9.1
