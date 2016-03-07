From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon,  7 Mar 2016 14:39:46 -0600
Subject: [Patch v4 5/6] ARM: dts: DRA7: Add TBCLK for PWMSS
In-Reply-To: <1457383187-17166-1-git-send-email-fcooper@ti.com>
References: <1457383187-17166-1-git-send-email-fcooper@ti.com>
Message-ID: <1457383187-17166-6-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vignesh R <vigneshr@ti.com>

tbclk is used by ehrpwm to generate PWM waveform on DRA7 SoC. Add Linux
clock to control ehrpwm tbclk.
The TRM says, tbclk is derived from SYSCLKOUT. SYSCLKOUT is nothing but
ehrpwm functional clock derived from the gateable interface and
functional clock of PWMSS(l4_root_clk_div).
Refer AM57x TRM SPRUHZ6E[1], Janurary 2016, Table 29-4 and
Section 29.2.2.1, Table 29-19 and the NOTE at the end of the table.

[1] http://www.ti.com/lit/ug/spruhz6e/spruhz6e.pdf

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version v4 changes:
Updated link to latest documentation

 arch/arm/boot/dts/dra7xx-clocks.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 357bede..d0bae06 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2146,4 +2146,28 @@
 		ti,bit-shift = <0>;
 		reg = <0x558>;
 	};
+
+       ehrpwm0_tbclk: ehrpwm0_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <20>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm1_tbclk: ehrpwm1_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <21>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm2_tbclk: ehrpwm2_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <22>;
+		reg = <0x0558>;
+	};
 };
-- 
2.7.0
