From: code@mmayer.net (Markus Mayer)
Date: Wed, 18 Jan 2017 16:29:32 -0800
Subject: [PATCH v5 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
In-Reply-To: <20170119002933.7529-1-code@mmayer.net>
References: <20170119002933.7529-1-code@mmayer.net>
Message-ID: <20170119002933.7529-2-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

Add binding document for brcm,brcmstb-cpu-clk-div.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    | 27 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt

diff --git a/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
new file mode 100644
index 0000000..c4acb53
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
@@ -0,0 +1,27 @@
+The CPU divider node serves as the sole clock for the CPU complex. It supports
+power-of-2 clock division, with a divider of "1" as the default highest-speed
+setting.
+
+Required properties:
+- compatible: shall be "brcm,brcmstb-cpu-clk-div"
+- reg: address and width of the divider configuration register
+- #clock-cells: shall be set to 0
+- clocks: phandle of clock provider which provides the source clock
+          (this would typically be a "fixed-clock" type PLL)
+- div-table: list of (raw_value,divider) ordered pairs that correspond to the
+             allowed clock divider settings
+- div-shift-width: least-significant bit position and width of divider value
+
+Optional properties:
+- clock-names: the clock may be named
+
+Example:
+	cpuclkdiv: cpu-clk-div at f03e257c {
+		compatible = "brcm,brcmstb-cpu-clk-div";
+		reg = <0xf03e257c 0x4>;
+		div-table = <0x00 1>;
+		div-shift-width = <0 5>;
+		#clock-cells = <0>;
+		clocks = <&cpupll>;
+		clock-names = "cpupll";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9..690761d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2786,6 +2786,7 @@ M:	bcm-kernel-feedback-list at broadcom.com
 L:	linux-pm at vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
+F:	Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
 F:	drivers/cpufreq/brcmstb*
 
 BROADCOM SPECIFIC AMBA DRIVER (BCMA)
-- 
2.7.4
