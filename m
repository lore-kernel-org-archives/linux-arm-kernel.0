From: b.galvani@gmail.com (Beniamino Galvani)
Date: Thu, 13 Nov 2014 20:32:03 +0100
Subject: [PATCH v3 3/3] ARM: dts: meson: add I2C controller nodes
In-Reply-To: <1415907123-4318-1-git-send-email-b.galvani@gmail.com>
References: <1415907123-4318-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1415907123-4318-4-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for I2C controllers A,B,AO, which are available in both
Meson6 and Meson8.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/boot/dts/meson.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index e6539ea..4f16aee 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -106,5 +106,35 @@
 			clocks = <&clk81>;
 			status = "disabled";
 		};
+
+		i2c_AO: i2c at c8100500 {
+			compatible = "amlogic,meson6-i2c";
+			reg = <0xc8100500 0x20>;
+			interrupts = <0 92 1>;
+			clocks = <&clk81>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c_A: i2c at c1108500 {
+			compatible = "amlogic,meson6-i2c";
+			reg = <0xc1108500 0x20>;
+			interrupts = <0 21 1>;
+			clocks = <&clk81>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c_B: i2c at c11087c0 {
+			compatible = "amlogic,meson6-i2c";
+			reg = <0xc11087c0 0x20>;
+			interrupts = <0 128 1>;
+			clocks = <&clk81>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 }; /* end of / */
-- 
1.9.1
