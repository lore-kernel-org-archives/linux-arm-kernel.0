From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 29 Jun 2014 20:32:24 +0200
Subject: [PATCH 4/4] clk: dts: document pxa27x clock binding
In-Reply-To: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
References: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1404066744-13416-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device-tree binding of Marvell PXA based SoCs.
PXA clocks are mostly fixed rate and fixed ratio clocks derived from an
external oscillator, and gated by a register set (CKEN or CKEN*).

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 .../devicetree/bindings/clock/pxa-clock.txt        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/pxa-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/pxa-clock.txt b/Documentation/devicetree/bindings/clock/pxa-clock.txt
new file mode 100644
index 0000000..beb28ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/pxa-clock.txt
@@ -0,0 +1,32 @@
+* Clock bindings for Marvell PXA chips
+
+Required properties:
+- compatible: Should be "marvell,pxa-clocks"
+- reg: Address and length of the CKEN register
+- #clock-cells: Should be <1>
+- clocks: the parent fixed rate clocks
+- clock-indices: the bit index in the CKEN register gating the clock
+- clock-outpout-names: the names of the clocks
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.
+
+Examples:
+
+pxa2xx_clks: pxa2xx_clks at 41300004 {
+	compatible = "marvell,pxa-clocks";
+	clocks = <&clk_14_857mhz>, <&clk_14_857mhz>
+	#clock-cells = <1>;
+	clock-output-names =
+		"pxa27x-ffuart", "pxa27x-btuart";
+	clock-indices = <CKEN_FFUART CKEN_BTUART>
+};
+
+
+* Core clock bindings for Marvell PXA27x chips
+
+Required properties:
+- compatible: Should be "marvell,pxa270-core-clocks"
+- #clock-cells: Should be <1>
+- clocks: the parent fixed rate clock, should be the 13MHz oscillator
+- clock-outpout-names: the names of the 7 core clocks
-- 
2.0.0.rc2
