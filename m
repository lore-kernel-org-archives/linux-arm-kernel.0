From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 14 May 2014 11:49:00 +0200
Subject: [PATCH v3 4/6] Documentation: bindings: add the berlin-ahci
 compatible to the ahci platform
In-Reply-To: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1400060942-10588-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The berlin-ahci driver allows Berlin SoCs to support their AHCI SATA controller.
Add the compatible to the device tree bindings documentation.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/ata/ahci-berlin.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-berlin.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-berlin.txt b/Documentation/devicetree/bindings/ata/ahci-berlin.txt
new file mode 100644
index 000000000000..10362fdc5b8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-berlin.txt
@@ -0,0 +1,18 @@
+* Marvell Berlin SATA nodes
+
+Required properties:
+- compatible: "marvell,berlin-ahci"
+- interrupts: interrupt mapping for the SATA IRQ
+- reg: address and length of the register
+- phys: references to the SATA PHY nodes
+- phy-names: should be "port0" or/and "port1"
+
+Example:
+	ahci: sata at f7e90000 {
+		compatible = "marvell,berlin-ahci";
+		reg = <0xf7e90000 0x1000>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&sata_phy0>, <&sata_phy1>;
+		phy-names = "port0", "port1";
+		status = "okay";
+	};
-- 
1.9.1
