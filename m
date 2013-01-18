From: rachna@ti.com (Patil, Rachna)
Date: Fri, 18 Jan 2013 16:18:59 +0530
Subject: [PATCH v3 8/8] arm/dts: AM335x-evm: Add TSC/ADC MFD device support
In-Reply-To: <cover.1358502134.git.rachna@ti.com>
References: <cover.1358502134.git.rachna@ti.com>
Message-ID: <1e33c3c4ac95fad513bf2785a5acff7a5f56d4b0.1358502134.git.rachna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Patil, Rachna" <rachna@ti.com>

Add support for core multifunctional device along
with its clients touchscreen and ADC.

Signed-off-by: Patil, Rachna <rachna@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   13 +++++++++++++
 arch/arm/boot/dts/am33xx.dtsi    |    8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d649644..ea28476 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -244,3 +244,16 @@
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
 };
+
+&tscadc {
+	tsc {
+		wires = <4>;
+		x-plate-resistance = <200>;
+		steps-to-configure = <5>;
+		wire-config = <0x00 0x11 0x22 0x33>;
+	};
+
+	adc {
+		adc-channels = <4>;
+	};
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c2f14e8..211ec42 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -385,5 +385,13 @@
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
+
+		tscadc: tscadc at 44e0d000 {
+			compatible = "ti,ti-tscadc";
+			reg = <0x44e0d000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <16>;
+			ti,hwmods = "adc_tsc";
+		};
 	};
 };
-- 
1.7.9.5
