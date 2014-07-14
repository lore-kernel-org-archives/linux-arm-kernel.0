From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 14 Jul 2014 16:12:20 +0530
Subject: [RESEND PATCH 5/8] ARM: dts: dra7xx-clocks: Add missing clocks for
 second PCIe PHY instance
In-Reply-To: <1405334543-25509-1-git-send-email-kishon@ti.com>
References: <1405334543-25509-1-git-send-email-kishon@ti.com>
Message-ID: <1405334543-25509-6-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added missing clocks used by second instance of PCIe PHY.
The documention for this nodes can be found @ ../bindings/clock/ti/gate.txt.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index fe5db55..b48f18b 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1173,6 +1173,14 @@
 		ti,bit-shift = <8>;
 	};
 
+	optfclk_pciephy2_32khz: optfclk_pciephy2_32khz at 4a0093b8 {
+		compatible = "ti,gate-clock";
+		clocks = <&sys_32k_ck>;
+		#clock-cells = <0>;
+		reg = <0x13b8>;
+		ti,bit-shift = <8>;
+	};
+
 	optfclk_pciephy_div: optfclk_pciephy_div at 4a00821c {
 		compatible = "ti,divider-clock";
 		clocks = <&apll_pcie_ck>;
@@ -1191,6 +1199,14 @@
 		ti,bit-shift = <9>;
 	};
 
+	optfclk_pciephy2_clk: optfclk_pciephy2_clk at 4a0093b8 {
+		compatible = "ti,gate-clock";
+		clocks = <&apll_pcie_ck>;
+		#clock-cells = <0>;
+		reg = <0x13b8>;
+		ti,bit-shift = <9>;
+	};
+
 	optfclk_pciephy1_div_clk: optfclk_pciephy1_div_clk at 4a0093b0 {
 		compatible = "ti,gate-clock";
 		clocks = <&optfclk_pciephy_div>;
@@ -1199,6 +1215,14 @@
 		ti,bit-shift = <10>;
 	};
 
+	optfclk_pciephy2_div_clk: optfclk_pciephy2_div_clk at 4a0093b8 {
+		compatible = "ti,gate-clock";
+		clocks = <&optfclk_pciephy_div>;
+		#clock-cells = <0>;
+		reg = <0x13b8>;
+		ti,bit-shift = <10>;
+	};
+
 	apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
-- 
1.7.9.5
