From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri,  9 Mar 2018 23:09:53 +0200
Subject: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider bindings
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
Message-ID: <20180309210958.16672-3-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This binding is intended to represent the interconnect hardware present
in some of the modern SoCs. Currently it consists only of a binding for
the interconnect hardware devices (provider).

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt         | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
new file mode 100644
index 000000000000..70612bb201e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -0,0 +1,47 @@
+Interconnect Provider Device Tree Bindings
+=========================================
+
+The purpose of this document is to define a common set of generic interconnect
+providers/consumers properties.
+
+
+= interconnect providers =
+
+The interconnect provider binding is intended to represent the interconnect
+controllers in the system. Each provider registers a set of interconnect
+nodes, which expose the interconnect related capabilities of the interconnect
+to consumer drivers. These capabilities can be throughput, latency, priority
+etc. The consumer drivers set constraints on interconnect path (or endpoints)
+depending on the usecase. Interconnect providers can also be interconnect
+consumers, such as in the case where two network-on-chip fabrics interface
+directly
+
+Required properties:
+- compatible : contains the interconnect provider vendor specific compatible
+	       string
+- reg : register space of the interconnect controller hardware
+
+Examples:
+
+		snoc: snoc at 580000 {
+			compatible = "qcom,msm8916-snoc";
+			reg = <0x580000 0x14000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
+			status = "okay";
+		};
+		bimc: bimc at 400000 {
+			compatible = "qcom,msm8916-bimc";
+			reg = <0x400000 0x62000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
+			status = "okay";
+		};
+		pnoc: pnoc at 500000 {
+			compatible = "qcom,msm8916-pnoc";
+			reg = <0x500000 0x11000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+			status = "okay";
+		};
+
