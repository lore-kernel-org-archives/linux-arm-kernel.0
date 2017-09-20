From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Sep 2017 15:46:15 -0700
Subject: [PATCH 04/10] ARM: dts: omap4: add clkctrl nodes
In-Reply-To: <20170920224621.16236-1-tony@atomide.com>
References: <20170920224621.16236-1-tony@atomide.com>
Message-ID: <20170920224621.16236-5-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

Add clkctrl nodes for OMAP4 SoC. These are going to be acting as
replacement for part of the existing clock data and the existing
clkctrl hooks under hwmod data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4.dtsi           |   1 +
 arch/arm/boot/dts/omap44xx-clocks.dtsi | 289 +++++++++++++++++++++++++++++++++
 2 files changed, 290 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/omap.h>
+#include <dt-bindings/clock/omap4.h>
 
 / {
 	compatible = "ti,omap4430", "ti,omap4";
diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -628,6 +628,7 @@
 		clock-frequency = <0>;
 	};
 };
+
 &prm_clocks {
 	sys_clkin_ck: sys_clkin_ck at 110 {
 		#clock-cells = <0>;
@@ -1631,3 +1632,291 @@
 		reg = <0x0224>;
 	};
 };
+
+&cm1 {
+	mpuss_cm: mpuss_cm at 300 {
+		compatible = "ti,omap4-cm";
+		reg = <0x300 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x300 0x100>;
+
+		mpuss_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	tesla_cm: tesla_cm at 400 {
+		compatible = "ti,omap4-cm";
+		reg = <0x400 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x400 0x100>;
+
+		tesla_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	abe_cm: abe_cm at 500 {
+		compatible = "ti,omap4-cm";
+		reg = <0x500 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x500 0x100>;
+
+		abe_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x6c>;
+			#clock-cells = <2>;
+		};
+	};
+
+};
+
+&cm2 {
+	l4_ao_cm: l4_ao_cm at 600 {
+		compatible = "ti,omap4-cm";
+		reg = <0x600 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x600 0x100>;
+
+		l4_ao_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x1c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_1_cm: l3_1_cm at 700 {
+		compatible = "ti,omap4-cm";
+		reg = <0x700 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x700 0x100>;
+
+		l3_1_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_2_cm: l3_2_cm at 800 {
+		compatible = "ti,omap4-cm";
+		reg = <0x800 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x800 0x100>;
+
+		l3_2_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x14>;
+			#clock-cells = <2>;
+		};
+	};
+
+	ducati_cm: ducati_cm at 900 {
+		compatible = "ti,omap4-cm";
+		reg = <0x900 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x900 0x100>;
+
+		ducati_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_dma_cm: l3_dma_cm at a00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xa00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xa00 0x100>;
+
+		l3_dma_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_emif_cm: l3_emif_cm at b00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xb00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xb00 0x100>;
+
+		l3_emif_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x1c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	d2d_cm: d2d_cm at c00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xc00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xc00 0x100>;
+
+		d2d_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4_cfg_cm: l4_cfg_cm at d00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xd00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xd00 0x100>;
+
+		l4_cfg_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x14>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_instr_cm: l3_instr_cm at e00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xe00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xe00 0x100>;
+
+		l3_instr_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x24>;
+			#clock-cells = <2>;
+		};
+	};
+
+	ivahd_cm: ivahd_cm at f00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xf00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xf00 0x100>;
+
+		ivahd_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xc>;
+			#clock-cells = <2>;
+		};
+	};
+
+	iss_cm: iss_cm at 1000 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1000 0x100>;
+
+		iss_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xc>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_dss_cm: l3_dss_cm at 1100 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1100 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1100 0x100>;
+
+		l3_dss_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_gfx_cm: l3_gfx_cm at 1200 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1200 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1200 0x100>;
+
+		l3_gfx_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_init_cm: l3_init_cm at 1300 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1300 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1300 0x100>;
+
+		l3_init_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xc4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4_per_cm: l4_per_cm at 1400 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1400 0x200>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1400 0x200>;
+
+		l4_per_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x144>;
+			#clock-cells = <2>;
+		};
+	};
+
+};
+
+&prm {
+	l4_wkup_cm: l4_wkup_cm at 1800 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1800 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1800 0x100>;
+
+		l4_wkup_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x5c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	emu_sys_cm: emu_sys_cm at 1a00 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1a00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1a00 0x100>;
+
+		emu_sys_clkctrl: clk at 20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+};
-- 
2.14.1
