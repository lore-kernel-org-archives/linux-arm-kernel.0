From: balbi@ti.com (Felipe Balbi)
Date: Fri, 23 Jan 2015 17:11:42 -0600
Subject: [PATCH 2/4] arm: dts: am4372: add missing debugss clocks
In-Reply-To: <1422054704-14915-1-git-send-email-balbi@ti.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
Message-ID: <1422054704-14915-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These clocks are needed so that OMAP HWMOD can
control them when we're using performance
monitors.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 51 ++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index c7dc9dab93a4..9000a5c5b719 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -362,6 +362,57 @@
 		clock-div = <1>;
 	};
 
+	dbg_sysclk_ck: dbg_sysclk_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&sys_clkin_ck>;
+		ti,bit-shift = <8>;
+		reg = <0x20>;
+	};
+
+	dbg_clka_ck: dbg_clka_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&sys_clkin_ck>;
+		ti,bit-shift = <9>;
+		reg = <0x20>;
+	};
+
+	dbg_clkb_ck: dbg_clkb_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&sys_clkin_ck>;
+		ti,bit-shift = <10>;
+		reg = <0x20>;
+	};
+
+	dbg_clkc_ck: dbg_clkc_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&sys_clkin_ck>;
+		ti,bit-shift = <11>;
+		reg = <0x20>;
+	};
+
+	trace_pmd_clk_mux_ck: trace_pmd_clk_mux_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&dbg_sysclk_ck>, <&dbg_clka_ck>,
+			<&dbg_clkb_ck>, <&dbg_clkc_ck>;
+		ti,bit-shift = <22>;
+		reg = <0x20>;
+	};
+
+	trace_clk_div_ck: trace_clk_div_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&trace_pmd_clk_mux_ck>;
+		ti,bit-shift = <24>;
+		ti,max-div = <4>;
+		reg = <0x20>;
+		ti,index-power-of-two;
+	};
+
 	pruss_ocp_gclk: pruss_ocp_gclk {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-- 
2.3.0-rc1
