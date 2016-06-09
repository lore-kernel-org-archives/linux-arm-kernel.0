From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Jun 2016 09:10:14 +0200
Subject: [PATCH 08/12] dt-bindings: mmc: Add Xenon description
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465456218-28354-9-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the Xenon SDHCI controller that we can find in the
Armada 37xx and the Armada 7K and 8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/mmc/sdhci-xenon.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-xenon.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
new file mode 100644
index 000000000000..e8d49fda5f12
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
@@ -0,0 +1,27 @@
+* Marvell sdhci-xenon controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-xenon drivers.
+
+Required properties:
+- compatible: Should be "marvell,xenon-sdhci".
+- reg:
+  one register area for the SDHCI registers.
+- interrupts-extended: interrupt number and attributes
+- clocks: array of clocks required for SDHCI.
+- bus-width: max bus width in unit of bit, normally should be 1 bit, 4 bits or 8 bits
+
+Optional properties:
+- non-removable: whether card is non-removable.
+- auto-cmd12: whether cmd12 is sent automatically.
+Example:
+
+sdhci0: sdhci at D8000 {
+	compatible = "marvell,xenon-sdhci";
+	reg = <0xD8000 0x300>;
+	interrupts-extended = <&gic GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+	non-removable;
+	bus-width = <8>;
+	auto-cmd12;
+	status = "disabled";
+};
-- 
2.5.0
