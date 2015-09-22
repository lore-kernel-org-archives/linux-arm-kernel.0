From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Sep 2015 22:12:35 +0800
Subject: [PATCH 4/5] dt-bindings: add binding for marvell berlin4ct SoC
In-Reply-To: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
References: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442931156-5877-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a dt-binding include for Marvell berlin4ct clock IDs.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 .../bindings/clock/marvell,berlin4ct.txt           | 38 +++++++++++++++
 include/dt-bindings/clock/berlin4ct.h              | 56 ++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin4ct.txt
 create mode 100644 include/dt-bindings/clock/berlin4ct.h

diff --git a/Documentation/devicetree/bindings/clock/marvell,berlin4ct.txt b/Documentation/devicetree/bindings/clock/marvell,berlin4ct.txt
new file mode 100644
index 0000000..a489473
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/marvell,berlin4ct.txt
@@ -0,0 +1,38 @@
+* Marvell berlin4ct Clock Controllers
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The berlin4ct clock subsystem generates and supplies clock to various
+controllers within the berlin4ct SoC. The berlin4ct contains 3 clock controller
+blocks: pll, gateclk, berlin-clk.
+
+Required Properties:
+
+- compatible: should be one of the following.
+  - "marvell,berlin-pll" - pll compatible
+  - "marvell,berlin4ct-clk" - berlin clk compatible
+  - "marvell,berlin4ct-gateclk" - gateclk compatible
+- reg: physical base address of the clock controller and length of memory mapped
+  region. For pll, the second reg defines the bypass register base address and
+  length of memory mapped region.
+- #clock-cells: for pll should 0, for gateclk and berlin clk should be 1.
+- #bypass-shift: the bypass bit in bypass register.
+
+Example:
+
+syspll: syspll {
+	compatible = "marvell,berlin-pll";
+	reg = <0xea0200 0x14>, <0xea0710 4>;
+	#clock-cells = <0>;
+	clocks = <&osc>;
+	bypass-shift = /bits/ 8 <0>;
+};
+
+clk: clk {
+	compatible = "marvell,berlin4ct-clk";
+	reg = <0xea0720 0x144>;
+	#clock-cells = <1>;
+	clocks = <&syspll>;
+};
diff --git a/include/dt-bindings/clock/berlin4ct.h b/include/dt-bindings/clock/berlin4ct.h
new file mode 100644
index 0000000..f742f6b
--- /dev/null
+++ b/include/dt-bindings/clock/berlin4ct.h
@@ -0,0 +1,56 @@
+/*
+ * Berlin2 BG2Q clock tree IDs
+ */
+
+/* GATE CLK */
+#define GATECLK_TSPSYS		0
+#define GATECLK_USB0CORE	1
+#define GATECLK_ZSPSYS		2
+#define GATECLK_SDIOSYS		3
+#define GATECLK_ETHCORE		4
+#define GATECLK_PCIE0SYS	5
+#define GATECLK_SATA0CORE	6
+#define GATECLK_NFCSYS		7
+#define GATECLK_EMMCSYS		8
+#define GATECLK_IHB0SYS		9
+
+/* BERLIN CLK */
+#define CLK_CPUFASTREF		0
+#define CLK_MEMFASTREF		1
+#define CLK_CFG			2
+#define CLK_PERIFSYS		3
+#define CLK_HB			4
+#define CLK_ATB			5
+#define CLK_DECODER		6
+#define CLK_DECODERM3		7
+#define CLK_DECODERPCUBE	8
+#define CLK_ENCODER		9
+#define CLK_OVPCORE		10
+#define CLK_GFX2DCORE		11
+#define CLK_GFX3DCORE		12
+#define CLK_GFX3DSH		13
+#define CLK_GFX3DSYS		14
+#define CLK_GFX2DSYS		15
+#define CLK_AVIOSYS		16
+#define CLK_VPPSYS		17
+#define CLK_EDDC		18
+#define CLK_AVIOBIU		19
+#define CLK_ZSP			20
+#define CLK_TSP			21
+#define CLK_TSPREF		22
+#define CLK_NDS			23
+#define CLK_NOCS		24
+#define CLK_APBCORE		25
+#define CLK_EMMC		26
+#define CLK_SD0			27
+#define CLK_SD1			28
+#define CLK_DLLMSTREF		29
+#define CLK_GETHRGMII		30
+#define CLK_GETHRGMIISYS	31
+#define CLK_USIM0		32
+#define CLK_PCIETEST		33
+#define CLK_USB2TEST		34
+#define CLK_USB3TEST		35
+#define CLK_USB3CORE		36
+#define CLK_NFCECC		37
+#define CLK_BCM			38
-- 
2.5.3
