From: stefan@agner.ch (Stefan Agner)
Date: Mon,  9 Jul 2018 17:48:45 +0200
Subject: [PATCH 5/8] ARM: dts: imx6qdl-apalis/-colibri: remove 1.8V regulator
In-Reply-To: <20180709154848.5401-1-stefan@agner.ch>
References: <20180709154848.5401-1-stefan@agner.ch>
Message-ID: <20180709154848.5401-5-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fixed 1.8V regulator is not used, and there is in fact no
fixed 1.8V regulator on the module. Remove it.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 8 --------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index f9bacc9ff2b6..2f711fffa06e 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -61,14 +61,6 @@
 		status = "disabled";
 	};
 
-	reg_1p8v: regulator-1p8v {
-		compatible = "regulator-fixed";
-		regulator-name = "1P8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
 	reg_2p5v: regulator-2p5v {
 		compatible = "regulator-fixed";
 		regulator-name = "2P5V";
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 8ae17fdf6cf6..1a147cb0bed0 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -56,14 +56,6 @@
 		status = "disabled";
 	};
 
-	reg_1p8v: regulator-1p8v {
-		compatible = "regulator-fixed";
-		regulator-name = "1P8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
 	reg_2p5v: regulator-2p5v {
 		compatible = "regulator-fixed";
 		regulator-name = "2P5V";
-- 
2.18.0
