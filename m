From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:38:01 -0600
Subject: [PATCH 9/9] ARM: dt: tegra: invert status=disable vs status=okay
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1336783081-16978-10-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

In tegra*.dtsi, set status="disable" for all HW modules that the board
design may choose not to use. Update all boards to specifically enable
any of those modules that are useful by setting status="okay".

This makes board files say which features they do use, rather than which
they don't, which feels more logical. It also makes the .dts files
slightly smaller, at least for existing content.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-cardhu.dts    |   48 +++++++--------------------------
 arch/arm/boot/dts/tegra-harmony.dts   |   40 +++++++++++----------------
 arch/arm/boot/dts/tegra-paz00.dts     |   44 ++++++++++++------------------
 arch/arm/boot/dts/tegra-seaboard.dts  |   37 +++++++++----------------
 arch/arm/boot/dts/tegra-trimslice.dts |   37 +++++++++----------------
 arch/arm/boot/dts/tegra-ventana.dts   |   40 +++++++++++----------------
 arch/arm/boot/dts/tegra20.dtsi        |   18 ++++++++++++
 arch/arm/boot/dts/tegra30.dtsi        |   19 +++++++++++++
 8 files changed, 123 insertions(+), 160 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index 3b5cd7b..e14bb45 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -64,34 +64,22 @@
 	};
 
 	serial at 70006000 {
+		status = "okay";
 		clock-frequency = <408000000>;
 	};
 
-	serial at 70006040 {
-		status = "disable";
-	};
-
-	serial at 70006200 {
-		status = "disable";
-	};
-
-	serial at 70006300 {
-		status = "disable";
-	};
-
-	serial at 70006400 {
-		status = "disable";
-	};
-
 	i2c at 7000c000 {
+		status = "okay";
 		clock-frequency = <100000>;
 	};
 
 	i2c at 7000c400 {
+		status = "okay";
 		clock-frequency = <100000>;
 	};
 
 	i2c at 7000c500 {
+		status = "okay";
 		clock-frequency = <100000>;
 
 		/* ALS and Proximity sensor */
@@ -104,10 +92,12 @@
 	};
 
 	i2c at 7000c700 {
+		status = "okay";
 		clock-frequency = <100000>;
 	};
 
 	i2c at 7000d000 {
+		status = "okay";
 		clock-frequency = <100000>;
 
 		wm8903: wm8903 at 1a {
@@ -139,38 +129,20 @@
 	};
 
 	ahub {
-		i2s at 70080300 {
-			status = "disable";
-		};
-
-		i2s at 70080500 {
-			status = "disable";
-		};
-
-		i2s at 70080600 {
-			status = "disable";
-		};
-
-		i2s at 70080700 {
-			status = "disable";
+		i2s at 70080400 {
+			status = "okay";
 		};
 	};
 
 	sdhci at 78000000 {
+		status = "okay";
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
 		power-gpios = <&gpio 31 0>; /* gpio PD7 */
 	};
 
-	sdhci at 78000200 {
-		status = "disable";
-	};
-
-	sdhci at 78000400 {
-		status = "disable";
-	};
-
 	sdhci at 78000600 {
+		status = "okay";
 		support-8bit;
 	};
 
diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index f18385d..6bcdad3 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -234,31 +234,17 @@
 		};
 	};
 
-	i2s at 70002a00 {
-		status = "disable";
-	};
-
-	serial at 70006000 {
-		status = "disable";
-	};
-
-	serial at 70006040 {
-		status = "disable";
-	};
-
-	serial at 70006200 {
-		status = "disable";
+	i2s at 70002800 {
+		status = "okay";
 	};
 
 	serial at 70006300 {
+		status = "okay";
 		clock-frequency = <216000000>;
 	};
 
-	serial at 70006400 {
-		status = "disable";
-	};
-
 	i2c at 7000c000 {
+		status = "okay";
 		clock-frequency = <400000>;
 
 		wm8903: wm8903 at 1a {
@@ -277,14 +263,17 @@
 	};
 
 	i2c at 7000c400 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c at 7000c500 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c at 7000d000 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
@@ -292,25 +281,28 @@
 		nvidia,invert-interrupt;
 	};
 
+	usb at c5000000 {
+		status = "okay";
+	};
+
 	usb at c5004000 {
+		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
 	};
 
-	sdhci at c8000000 {
-		status = "disable";
+	usb at c5008000 {
+		status = "okay";
 	};
 
 	sdhci at c8000200 {
+		status = "okay";
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 155 0>; /* gpio PT3 */
 	};
 
-	sdhci at c8000400 {
-		status = "disable";
-	};
-
 	sdhci at c8000600 {
+		status = "okay";
 		cd-gpios = <&gpio 58 0>; /* gpio PH2 */
 		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 6539e89..cb366f0 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -226,31 +226,22 @@
 		};
 	};
 
-	i2s at 70002a00 {
-		status = "disable";
+	i2s at 70002800 {
+		status = "okay";
 	};
 
 	serial at 70006000 {
+		status = "okay";
 		clock-frequency = <216000000>;
 	};
 
-	serial at 70006040 {
-		status = "disable";
-	};
-
 	serial at 70006200 {
+		status = "okay";
 		clock-frequency = <216000000>;
 	};
 
-	serial at 70006300 {
-		status = "disable";
-	};
-
-	serial at 70006400 {
-		status = "disable";
-	};
-
 	i2c at 7000c000 {
+		status = "okay";
 		clock-frequency = <400000>;
 
 		alc5632: alc5632 at 1e {
@@ -262,13 +253,10 @@
 	};
 
 	i2c at 7000c400 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
-	i2c at 7000c500 {
-		status = "disable";
-	};
-
 	nvec {
 		compatible = "nvidia,nvec";
 		reg = <0x7000c500 0x100>;
@@ -281,6 +269,7 @@
 	};
 
 	i2c at 7000d000 {
+		status = "okay";
 		clock-frequency = <400000>;
 
 		adt7461 at 4c {
@@ -289,25 +278,28 @@
 		};
 	};
 
+	usb at c5000000 {
+		status = "okay";
+	};
+
 	usb at c5004000 {
+		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
 	};
 
+	usb at c5008000 {
+		status = "okay";
+	};
+
 	sdhci at c8000000 {
+		status = "okay";
 		cd-gpios = <&gpio 173 0>; /* gpio PV5 */
 		wp-gpios = <&gpio 57 0>;  /* gpio PH1 */
 		power-gpios = <&gpio 169 0>; /* gpio PV1 */
 	};
 
-	sdhci at c8000200 {
-		status = "disable";
-	};
-
-	sdhci at c8000400 {
-		status = "disable";
-	};
-
 	sdhci at c8000600 {
+		status = "okay";
 		support-8bit;
 	};
 
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index 88f3b8e..21b586e 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -257,31 +257,17 @@
 		};
 	};
 
-	i2s at 70002a00 {
-		status = "disable";
-	};
-
-	serial at 70006000 {
-		status = "disable";
-	};
-
-	serial at 70006040 {
-		status = "disable";
-	};
-
-	serial at 70006200 {
-		status = "disable";
+	i2s at 70002800 {
+		status = "okay";
 	};
 
 	serial at 70006300 {
+		status = "okay";
 		clock-frequency = <216000000>;
 	};
 
-	serial at 70006400 {
-		status = "disable";
-	};
-
 	i2c at 7000c000 {
+		status = "okay";
 		clock-frequency = <400000>;
 
 		wm8903: wm8903 at 1a {
@@ -315,6 +301,7 @@
 	};
 
 	i2c at 7000c400 {
+		status = "okay";
 		clock-frequency = <100000>;
 
 		smart-battery at b {
@@ -326,10 +313,12 @@
 	};
 
 	i2c at 7000c500 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c at 7000d000 {
+		status = "okay";
 		clock-frequency = <400000>;
 
 		temperature-sensor at 4c {
@@ -384,29 +373,29 @@
 	};
 
 	usb at c5000000 {
+		status = "okay";
 		nvidia,vbus-gpio = <&gpio 24 0>; /* PD0 */
 		dr_mode = "otg";
 	};
 
 	usb at c5004000 {
+		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
 	};
 
-	sdhci at c8000000 {
-		status = "disable";
-	};
-
-	sdhci at c8000200 {
-		status = "disable";
+	usb at c5008000 {
+		status = "okay";
 	};
 
 	sdhci at c8000400 {
+		status = "okay";
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 	};
 
 	sdhci at c8000600 {
+		status = "okay";
 		support-8bit;
 	};
 
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 1dea6cc..6fc52af 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -240,39 +240,27 @@
 		};
 	};
 
-	i2s at 70002a00 {
-		status = "disable";
+	i2s at 70002800 {
+		status = "okay";
 	};
 
 	serial at 70006000 {
+		status = "okay";
 		clock-frequency = <216000000>;
 	};
 
-	serial at 70006040 {
-		status = "disable";
-	};
-
-	serial at 70006200 {
-		status = "disable";
-	};
-
-	serial at 70006300 {
-		status = "disable";
-	};
-
-	serial at 70006400 {
-		status = "disable";
-	};
-
 	i2c at 7000c000 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c at 7000c400 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c at 7000c500 {
+		status = "okay";
 		clock-frequency = <400000>;
 
 		codec: codec at 1a {
@@ -286,23 +274,24 @@
 		};
 	};
 
-	i2c at 7000d000 {
-		status = "disable";
+	usb at c5000000 {
+		status = "okay";
 	};
 
 	usb at c5004000 {
 		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
 	};
 
-	sdhci at c8000200 {
-		status = "disable";
+	usb at c5008000 {
+		status = "okay";
 	};
 
-	sdhci at c8000400 {
-		status = "disable";
+	sdhci at c8000000 {
+		status = "okay";
 	};
 
 	sdhci at c8000600 {
+		status = "okay";
 		cd-gpios = <&gpio 121 0>; /* gpio PP1 */
 		wp-gpios = <&gpio 122 0>; /* gpio PP2 */
 	};
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 6de4c10..15d8fdb 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -240,31 +240,17 @@
 		};
 	};
 
-	i2s at 70002a00 {
-		status = "disable";
-	};
-
-	serial at 70006000 {
-		status = "disable";
-	};
-
-	serial at 70006040 {
-		status = "disable";
-	};
-
-	serial at 70006200 {
-		status = "disable";
+	i2s at 70002800 {
+		status = "okay";
 	};
 
 	serial at 70006300 {
+		status = "okay";
 		clock-frequency = <216000000>;
 	};
 
-	serial at 70006400 {
-		status = "disable";
-	};
-
 	i2c at 7000c000 {
+		status = "okay";
 		clock-frequency = <400000>;
 
 		wm8903: wm8903 at 1a {
@@ -291,36 +277,42 @@
 	};
 
 	i2c at 7000c400 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c at 7000c500 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c at 7000d000 {
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
-	usb at c5004000 {
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+	usb at c5000000 {
+		status = "okay";
 	};
 
-	sdhci at c8000000 {
-		status = "disable";
+	usb at c5004000 {
+		status = "okay";
+		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
 	};
 
-	sdhci at c8000200 {
-		status = "disable";
+	usb at c5008000 {
+		status = "okay";
 	};
 
 	sdhci at c8000400 {
+		status = "okay";
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 	};
 
 	sdhci at c8000600 {
+		status = "okay";
 		support-8bit;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index df34def..c417d67 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -72,6 +72,7 @@
 		reg = <0x70002800 0x200>;
 		interrupts = <0 13 0x04>;
 		nvidia,dma-request-selector = <&apbdma 2>;
+		status = "disable";
 	};
 
 	tegra_i2s2: i2s at 70002a00 {
@@ -79,6 +80,7 @@
 		reg = <0x70002a00 0x200>;
 		interrupts = <0 3 0x04>;
 		nvidia,dma-request-selector = <&apbdma 1>;
+		status = "disable";
 	};
 
 	serial at 70006000 {
@@ -86,6 +88,7 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
+		status = "disable";
 	};
 
 	serial at 70006040 {
@@ -93,6 +96,7 @@
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
+		status = "disable";
 	};
 
 	serial at 70006200 {
@@ -100,6 +104,7 @@
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
+		status = "disable";
 	};
 
 	serial at 70006300 {
@@ -107,6 +112,7 @@
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
+		status = "disable";
 	};
 
 	serial at 70006400 {
@@ -114,6 +120,7 @@
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 91 0x04>;
+		status = "disable";
 	};
 
 	i2c at 7000c000 {
@@ -122,6 +129,7 @@
 		interrupts = <0 38 0x04>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disable";
 	};
 
 	i2c at 7000c400 {
@@ -130,6 +138,7 @@
 		interrupts = <0 84 0x04>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disable";
 	};
 
 	i2c at 7000c500 {
@@ -138,6 +147,7 @@
 		interrupts = <0 92 0x04>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disable";
 	};
 
 	i2c at 7000d000 {
@@ -146,6 +156,7 @@
 		interrupts = <0 53 0x04>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disable";
 	};
 
 	pmc {
@@ -179,6 +190,7 @@
 		interrupts = <0 20 0x04>;
 		phy_type = "utmi";
 		nvidia,has-legacy-mode;
+		status = "disable";
 	};
 
 	usb at c5004000 {
@@ -186,6 +198,7 @@
 		reg = <0xc5004000 0x4000>;
 		interrupts = <0 21 0x04>;
 		phy_type = "ulpi";
+		status = "disable";
 	};
 
 	usb at c5008000 {
@@ -193,30 +206,35 @@
 		reg = <0xc5008000 0x4000>;
 		interrupts = <0 97 0x04>;
 		phy_type = "utmi";
+		status = "disable";
 	};
 
 	sdhci at c8000000 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000000 0x200>;
 		interrupts = <0 14 0x04>;
+		status = "disable";
 	};
 
 	sdhci at c8000200 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000200 0x200>;
 		interrupts = <0 15 0x04>;
+		status = "disable";
 	};
 
 	sdhci at c8000400 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000400 0x200>;
 		interrupts = <0 19 0x04>;
+		status = "disable";
 	};
 
 	sdhci at c8000600 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000600 0x200>;
 		interrupts = <0 31 0x04>;
+		status = "disable";
 	};
 
 	pmu {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 5a1c85f..2dcc09e 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -82,6 +82,7 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
+		status = "disable";
 	};
 
 	serial at 70006040 {
@@ -89,6 +90,7 @@
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
+		status = "disable";
 	};
 
 	serial at 70006200 {
@@ -96,6 +98,7 @@
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
+		status = "disable";
 	};
 
 	serial at 70006300 {
@@ -103,6 +106,7 @@
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
+		status = "disable";
 	};
 
 	serial at 70006400 {
@@ -110,6 +114,7 @@
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 91 0x04>;
+		status = "disable";
 	};
 
 	i2c at 7000c000 {
@@ -118,6 +123,7 @@
 		interrupts = <0 38 0x04>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disable";
 	};
 
 	i2c at 7000c400 {
@@ -126,6 +132,7 @@
 		interrupts = <0 84 0x04>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disable";
 	};
 
 	i2c at 7000c500 {
@@ -134,6 +141,7 @@
 		interrupts = <0 92 0x04>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disable";
 	};
 
 	i2c at 7000c700 {
@@ -142,6 +150,7 @@
 		interrupts = <0 120 0x04>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disable";
 	};
 
 	i2c at 7000d000 {
@@ -150,6 +159,7 @@
 		interrupts = <0 53 0x04>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disable";
 	};
 
 	pmc {
@@ -191,30 +201,35 @@
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080300 0x100>;
 			nvidia,ahub-cif-ids = <4 4>;
+			status = "disable";
 		};
 
 		tegra_i2s1: i2s at 70080400 {
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080400 0x100>;
 			nvidia,ahub-cif-ids = <5 5>;
+			status = "disable";
 		};
 
 		tegra_i2s2: i2s at 70080500 {
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080500 0x100>;
 			nvidia,ahub-cif-ids = <6 6>;
+			status = "disable";
 		};
 
 		tegra_i2s3: i2s at 70080600 {
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080600 0x100>;
 			nvidia,ahub-cif-ids = <7 7>;
+			status = "disable";
 		};
 
 		tegra_i2s4: i2s at 70080700 {
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080700 0x100>;
 			nvidia,ahub-cif-ids = <8 8>;
+			status = "disable";
 		};
 	};
 
@@ -222,24 +237,28 @@
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <0 14 0x04>;
+		status = "disable";
 	};
 
 	sdhci at 78000200 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <0 15 0x04>;
+		status = "disable";
 	};
 
 	sdhci at 78000400 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <0 19 0x04>;
+		status = "disable";
 	};
 
 	sdhci at 78000600 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <0 31 0x04>;
+		status = "disable";
 	};
 
 	pmu {
-- 
1.7.0.4
