From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 25 Jan 2015 19:10:08 +0530
Subject: [PATCH v5 3/4] ARM: sunxi: dts: Add PS2 nodes to dtsi for A10,A20
In-Reply-To: <1422193209-17787-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1422193209-17787-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1422193209-17787-4-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   16 ++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi |   16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ae35397..134100b 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -943,5 +943,21 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		ps20: ps2 at 01c2a000 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <62>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+
+		ps21: ps2 at 01c2a400 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <63>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e10c2b8..d7fc31f 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1208,5 +1208,21 @@
 			#interrupt-cells = <3>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
+
+		ps20: ps2 at 01c2a000 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+
+		ps21: ps2 at 01c2a400 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
