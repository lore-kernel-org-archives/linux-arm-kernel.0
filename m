From: stefan@agner.ch (Stefan Agner)
Date: Mon,  9 Jul 2018 17:48:47 +0200
Subject: [PATCH 7/8] ARM: dts: imx6qdl-apalis/-colibri: assign VDDD to SGTL5000
In-Reply-To: <20180709154848.5401-1-stefan@agner.ch>
References: <20180709154848.5401-1-stefan@agner.ch>
Message-ID: <20180709154848.5401-7-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VDDD is connected to VGEN4 of the PF0100. This rail should only
run at 1.8V since there are multiple consumer and they all
expect the rail to be at 1.8V.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 3 ++-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 6813f4326807..8c04f42fdb71 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -289,7 +289,7 @@
 
 			vgen4_reg: vgen4 {
 				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
@@ -316,6 +316,7 @@
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_module_3v3_audio>;
 		VDDIO-supply = <&reg_module_3v3>;
+		VDDD-supply = <&vgen4_reg>;
 	};
 
 	/* STMPE811 touch screen controller */
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 9a3bac5be5e2..6821ea511051 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -219,7 +219,7 @@
 
 			vgen4_reg: vgen4 {
 				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
@@ -246,6 +246,7 @@
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_module_3v3_audio>;
 		VDDIO-supply = <&reg_module_3v3>;
+		VDDD-supply = <&vgen4_reg>;
 		lrclk-strength = <3>;
 	};
 
-- 
2.18.0
