From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  9 Sep 2014 16:44:03 +0200
Subject: [PATCH v2 3/8] Documentation: bindings: net: add the Marvell PXA168
 Ethernet controller
In-Reply-To: <1410273848-24663-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1410273848-24663-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1410273848-24663-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the binding documentation for the Marvell PXA168 Ethernet
controller, following its DT support.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/net/marvell-pxa168.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell-pxa168.txt

diff --git a/Documentation/devicetree/bindings/net/marvell-pxa168.txt b/Documentation/devicetree/bindings/net/marvell-pxa168.txt
new file mode 100644
index 000000000000..3a5320ad09a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell-pxa168.txt
@@ -0,0 +1,22 @@
+* Marvell PXA168 Ethernet Controller
+
+Required properties:
+- compatible: should be "marvell,pxa168-eth".
+- reg: address and length of the register set for the device.
+- interrupts: interrupt for the device.
+- clocks: pointer to the clock for the device.
+- clock-names: should be "MFUCLK".
+
+Optional properties:
+- port-id: should be '0','1' or '2'.
+- phy-addr: MDIO address of the PHY.
+
+Example:
+
+	eth0: ethernet at f7b90000 {
+		compatible = "marvell,pxa168-eth";
+		reg = <0xf7b90000 0x10000>;
+		clocks = <&chip CLKID_GETH0>;
+		clock-names = "MFUCLK";
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.9.1
