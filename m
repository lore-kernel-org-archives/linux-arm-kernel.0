From: dev@lynxeye.de (Lucas Stach)
Date: Wed,  8 Apr 2015 21:46:06 +0200
Subject: [PATCH v2 1/5] mtd: nand: tegra: add devicetree binding
In-Reply-To: <1428522370-18035-1-git-send-email-dev@lynxeye.de>
References: <1428522370-18035-1-git-send-email-dev@lynxeye.de>
Message-ID: <1428522370-18035-2-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the devicetree binding for the Tegra 2 NAND flash
controller.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 .../bindings/mtd/nvidia,tegra20-nand.txt           | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
new file mode 100644
index 0000000..522d442
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
@@ -0,0 +1,29 @@
+NVIDIA Tegra NAND Flash controller
+
+Required properties:
+- compatible: Must be one of:
+  - "nvidia,tegra20-nand"
+- reg: MMIO address range
+- interrupts: interrupt output of the NFC controller
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - nand
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: Must include the following entries:
+  - nand
+
+Optional properties:
+- nvidia,wp-gpios: GPIO used to disable write protection of the flash
+
+  Example:
+	nand at 70008000 {
+		compatible = "nvidia,tegra20-nand";
+		reg = <0x70008000 0x100>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
+		clock-names = "nand";
+		resets = <&tegra_car 13>;
+		reset-names = "nand";
+	};
-- 
2.1.0
