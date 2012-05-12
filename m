From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:37:59 -0600
Subject: [PATCH 7/9] ARM: dt: tegra: sort nodes based on bus order
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1336783081-16978-8-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Sort the nodes according to the following rules:
* First, any overrides for properties or nodes created by included files,
  in the order they appeared in the include file.
* Second, any nodes with a reg property, in numerical order.
* Third, any nodes without a reg property, in alphabetical order of node
  name.

The second sorting rule at least will probably help if/when we need to
explicitly insert nodes for the various busses in Tegra; that will just
be an indentation change rather than also a node re-ordering.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-cardhu.dts    |   36 ++++----
 arch/arm/boot/dts/tegra-harmony.dts   |   96 +++++++++---------
 arch/arm/boot/dts/tegra-paz00.dts     |   88 ++++++++--------
 arch/arm/boot/dts/tegra-seaboard.dts  |  164 +++++++++++++++---------------
 arch/arm/boot/dts/tegra-trimslice.dts |   60 ++++++------
 arch/arm/boot/dts/tegra-ventana.dts   |   86 ++++++++--------
 arch/arm/boot/dts/tegra20.dtsi        |  182 ++++++++++++++++----------------
 arch/arm/boot/dts/tegra30.dtsi        |  178 ++++++++++++++++----------------
 8 files changed, 445 insertions(+), 445 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index 653d628..3b5cd7b 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -138,24 +138,6 @@
 		};
 	};
 
-	sdhci at 78000000 {
-		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
-		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
-		power-gpios = <&gpio 31 0>; /* gpio PD7 */
-	};
-
-	sdhci at 78000200 {
-		status = "disable";
-	};
-
-	sdhci at 78000400 {
-		status = "disable";
-	};
-
-	sdhci at 78000600 {
-		support-8bit;
-	};
-
 	ahub {
 		i2s at 70080300 {
 			status = "disable";
@@ -174,6 +156,24 @@
 		};
 	};
 
+	sdhci at 78000000 {
+		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
+		power-gpios = <&gpio 31 0>; /* gpio PD7 */
+	};
+
+	sdhci at 78000200 {
+		status = "disable";
+	};
+
+	sdhci at 78000400 {
+		status = "disable";
+	};
+
+	sdhci at 78000600 {
+		support-8bit;
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-wm8903-cardhu",
 			     "nvidia,tegra-audio-wm8903";
diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 759e289..f18385d 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -234,8 +234,28 @@
 		};
 	};
 
-	pmc {
-		nvidia,invert-interrupt;
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	serial at 70006000 {
+		status = "disable";
+	};
+
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		status = "disable";
+	};
+
+	serial at 70006300 {
+		clock-frequency = <216000000>;
+	};
+
+	serial at 70006400 {
+		status = "disable";
 	};
 
 	i2c at 7000c000 {
@@ -268,52 +288,12 @@
 		clock-frequency = <400000>;
 	};
 
-	i2s at 70002a00 {
-		status = "disable";
-	};
-
-	sound {
-		compatible = "nvidia,tegra-audio-wm8903-harmony",
-			     "nvidia,tegra-audio-wm8903";
-		nvidia,model = "NVIDIA Tegra Harmony";
-
-		nvidia,audio-routing =
-			"Headphone Jack", "HPOUTR",
-			"Headphone Jack", "HPOUTL",
-			"Int Spk", "ROP",
-			"Int Spk", "RON",
-			"Int Spk", "LOP",
-			"Int Spk", "LON",
-			"Mic Jack", "MICBIAS",
-			"IN1L", "Mic Jack";
-
-		nvidia,i2s-controller = <&tegra_i2s1>;
-		nvidia,audio-codec = <&wm8903>;
-
-		nvidia,spkr-en-gpios = <&wm8903 2 0>;
-		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
-		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
-		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
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
-	};
-
-	serial at 70006300 {
-		clock-frequency = <216000000>;
+	pmc {
+		nvidia,invert-interrupt;
 	};
 
-	serial at 70006400 {
-		status = "disable";
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
 	};
 
 	sdhci at c8000000 {
@@ -337,7 +317,27 @@
 		support-8bit;
 	};
 
-	usb at c5004000 {
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+	sound {
+		compatible = "nvidia,tegra-audio-wm8903-harmony",
+			     "nvidia,tegra-audio-wm8903";
+		nvidia,model = "NVIDIA Tegra Harmony";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"Int Spk", "ROP",
+			"Int Spk", "RON",
+			"Int Spk", "LOP",
+			"Int Spk", "LON",
+			"Mic Jack", "MICBIAS",
+			"IN1L", "Mic Jack";
+
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,audio-codec = <&wm8903>;
+
+		nvidia,spkr-en-gpios = <&wm8903 2 0>;
+		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
+		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
 	};
 };
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index d469322..b500212 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -226,6 +226,30 @@
 		};
 	};
 
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	serial at 70006000 {
+		clock-frequency = <216000000>;
+	};
+
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		clock-frequency = <216000000>;
+	};
+
+	serial at 70006300 {
+		status = "disable";
+	};
+
+	serial at 70006400 {
+		status = "disable";
+	};
+
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 
@@ -265,48 +289,8 @@
 		};
 	};
 
-	i2s at 70002a00 {
-		status = "disable";
-	};
-
-	sound {
-		compatible = "nvidia,tegra-audio-alc5632-paz00",
-			"nvidia,tegra-audio-alc5632";
-
-		nvidia,model = "Compal PAZ00";
-
-		nvidia,audio-routing =
-			"Int Spk", "SPKOUT",
-			"Int Spk", "SPKOUTN",
-			"Headset Mic", "MICBIAS1",
-			"MIC1", "Headset Mic",
-			"Headset Stereophone", "HPR",
-			"Headset Stereophone", "HPL",
-			"DMICDAT", "Digital Mic";
-
-		nvidia,audio-codec = <&alc5632>;
-		nvidia,i2s-controller = <&tegra_i2s1>;
-		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
-	};
-
-	serial at 70006000 {
-		clock-frequency = <216000000>;
-	};
-
-	serial at 70006040 {
-		status = "disable";
-	};
-
-	serial at 70006200 {
-		clock-frequency = <216000000>;
-	};
-
-	serial at 70006300 {
-		status = "disable";
-	};
-
-	serial at 70006400 {
-		status = "disable";
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
 	};
 
 	sdhci at c8000000 {
@@ -348,7 +332,23 @@
 		};
 	};
 
-	usb at c5004000 {
-		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
+	sound {
+		compatible = "nvidia,tegra-audio-alc5632-paz00",
+			"nvidia,tegra-audio-alc5632";
+
+		nvidia,model = "Compal PAZ00";
+
+		nvidia,audio-routing =
+			"Int Spk", "SPKOUT",
+			"Int Spk", "SPKOUTN",
+			"Headset Mic", "MICBIAS1",
+			"MIC1", "Headset Mic",
+			"Headset Stereophone", "HPR",
+			"Headset Stereophone", "HPL",
+			"DMICDAT", "Digital Mic";
+
+		nvidia,audio-codec = <&alc5632>;
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
 	};
 };
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index c935a28..88f3b8e 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -257,6 +257,30 @@
 		};
 	};
 
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	serial at 70006000 {
+		status = "disable";
+	};
+
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		status = "disable";
+	};
+
+	serial at 70006300 {
+		clock-frequency = <216000000>;
+	};
+
+	serial at 70006400 {
+		status = "disable";
+	};
+
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 
@@ -321,50 +345,51 @@
 		};
 	};
 
-	i2s at 70002a00 {
-		status = "disable";
-	};
-
-	sound {
-		compatible = "nvidia,tegra-audio-wm8903-seaboard",
-			     "nvidia,tegra-audio-wm8903";
-		nvidia,model = "NVIDIA Tegra Seaboard";
-
-		nvidia,audio-routing =
-			"Headphone Jack", "HPOUTR",
-			"Headphone Jack", "HPOUTL",
-			"Int Spk", "ROP",
-			"Int Spk", "RON",
-			"Int Spk", "LOP",
-			"Int Spk", "LON",
-			"Mic Jack", "MICBIAS",
-			"IN1R", "Mic Jack";
-
-		nvidia,i2s-controller = <&tegra_i2s1>;
-		nvidia,audio-codec = <&wm8903>;
-
-		nvidia,spkr-en-gpios = <&wm8903 2 0>;
-		nvidia,hp-det-gpios = <&gpio 185 0>; /* gpio PX1 */
-	};
-
-	serial at 70006000 {
-		status = "disable";
-	};
-
-	serial at 70006040 {
-		status = "disable";
-	};
+	emc {
+		emc-table at 190000 {
+			reg = <190000>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = <190000>;
+			nvidia,emc-registers = <0x0000000c 0x00000026
+				0x00000009 0x00000003 0x00000004 0x00000004
+				0x00000002 0x0000000c 0x00000003 0x00000003
+				0x00000002 0x00000001 0x00000004 0x00000005
+				0x00000004 0x00000009 0x0000000d 0x0000059f
+				0x00000000 0x00000003 0x00000003 0x00000003
+				0x00000003 0x00000001 0x0000000b 0x000000c8
+				0x00000003 0x00000007 0x00000004 0x0000000f
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0xa06204ae
+				0x007dc010 0x00000000 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000>;
+		};
 
-	serial at 70006200 {
-		status = "disable";
+		emc-table at 380000 {
+			reg = <380000>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = <380000>;
+			nvidia,emc-registers = <0x00000017 0x0000004b
+				0x00000012 0x00000006 0x00000004 0x00000005
+				0x00000003 0x0000000c 0x00000006 0x00000006
+				0x00000003 0x00000001 0x00000004 0x00000005
+				0x00000004 0x00000009 0x0000000d 0x00000b5f
+				0x00000000 0x00000003 0x00000003 0x00000006
+				0x00000006 0x00000001 0x00000011 0x000000c8
+				0x00000003 0x0000000e 0x00000007 0x0000000f
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0xe044048b
+				0x007d8010 0x00000000 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000>;
+		};
 	};
 
-	serial at 70006300 {
-		clock-frequency = <216000000>;
+	usb at c5000000 {
+		nvidia,vbus-gpio = <&gpio 24 0>; /* PD0 */
+		dr_mode = "otg";
 	};
 
-	serial at 70006400 {
-		status = "disable";
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
 	};
 
 	sdhci at c8000000 {
@@ -385,11 +410,6 @@
 		support-8bit;
 	};
 
-	usb at c5000000 {
-		nvidia,vbus-gpio = <&gpio 24 0>; /* PD0 */
-		dr_mode = "otg";
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -410,45 +430,25 @@
 		};
 	};
 
-	emc {
-		emc-table at 190000 {
-			reg = <190000>;
-			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = <190000>;
-			nvidia,emc-registers = <0x0000000c 0x00000026
-				0x00000009 0x00000003 0x00000004 0x00000004
-				0x00000002 0x0000000c 0x00000003 0x00000003
-				0x00000002 0x00000001 0x00000004 0x00000005
-				0x00000004 0x00000009 0x0000000d 0x0000059f
-				0x00000000 0x00000003 0x00000003 0x00000003
-				0x00000003 0x00000001 0x0000000b 0x000000c8
-				0x00000003 0x00000007 0x00000004 0x0000000f
-				0x00000002 0x00000000 0x00000000 0x00000002
-				0x00000000 0x00000000 0x00000083 0xa06204ae
-				0x007dc010 0x00000000 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000>;
-		};
+	sound {
+		compatible = "nvidia,tegra-audio-wm8903-seaboard",
+			     "nvidia,tegra-audio-wm8903";
+		nvidia,model = "NVIDIA Tegra Seaboard";
 
-		emc-table at 380000 {
-			reg = <380000>;
-			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = <380000>;
-			nvidia,emc-registers = <0x00000017 0x0000004b
-				0x00000012 0x00000006 0x00000004 0x00000005
-				0x00000003 0x0000000c 0x00000006 0x00000006
-				0x00000003 0x00000001 0x00000004 0x00000005
-				0x00000004 0x00000009 0x0000000d 0x00000b5f
-				0x00000000 0x00000003 0x00000003 0x00000006
-				0x00000006 0x00000001 0x00000011 0x000000c8
-				0x00000003 0x0000000e 0x00000007 0x0000000f
-				0x00000002 0x00000000 0x00000000 0x00000002
-				0x00000000 0x00000000 0x00000083 0xe044048b
-				0x007d8010 0x00000000 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000>;
-		};
-	};
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"Int Spk", "ROP",
+			"Int Spk", "RON",
+			"Int Spk", "LOP",
+			"Int Spk", "LON",
+			"Mic Jack", "MICBIAS",
+			"IN1R", "Mic Jack";
 
-	usb at c5004000 {
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,audio-codec = <&wm8903>;
+
+		nvidia,spkr-en-gpios = <&wm8903 2 0>;
+		nvidia,hp-det-gpios = <&gpio 185 0>; /* gpio PX1 */
 	};
 };
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index eebcf50..1dea6cc 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -240,6 +240,30 @@
 		};
 	};
 
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	serial at 70006000 {
+		clock-frequency = <216000000>;
+	};
+
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		status = "disable";
+	};
+
+	serial at 70006300 {
+		status = "disable";
+	};
+
+	serial at 70006400 {
+		status = "disable";
+	};
+
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 	};
@@ -266,34 +290,8 @@
 		status = "disable";
 	};
 
-	i2s at 70002a00 {
-		status = "disable";
-	};
-
-	sound {
-		compatible = "nvidia,tegra-audio-trimslice";
-		nvidia,i2s-controller = <&tegra_i2s1>;
-		nvidia,audio-codec = <&codec>;
-	};
-
-	serial at 70006000 {
-		clock-frequency = <216000000>;
-	};
-
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
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
 	};
 
 	sdhci at c8000200 {
@@ -309,7 +307,9 @@
 		wp-gpios = <&gpio 122 0>; /* gpio PP2 */
 	};
 
-	usb at c5004000 {
-		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
+	sound {
+		compatible = "nvidia,tegra-audio-trimslice";
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,audio-codec = <&codec>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index e64318d..6de4c10 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -240,6 +240,30 @@
 		};
 	};
 
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	serial at 70006000 {
+		status = "disable";
+	};
+
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		status = "disable";
+	};
+
+	serial at 70006300 {
+		clock-frequency = <216000000>;
+	};
+
+	serial at 70006400 {
+		status = "disable";
+	};
+
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 
@@ -278,10 +302,28 @@
 		clock-frequency = <400000>;
 	};
 
-	i2s at 70002a00 {
+	usb at c5004000 {
+		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+	};
+
+	sdhci at c8000000 {
 		status = "disable";
 	};
 
+	sdhci at c8000200 {
+		status = "disable";
+	};
+
+	sdhci at c8000400 {
+		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
+		power-gpios = <&gpio 70 0>; /* gpio PI6 */
+	};
+
+	sdhci at c8000600 {
+		support-8bit;
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-wm8903-ventana",
 			     "nvidia,tegra-audio-wm8903";
@@ -305,46 +347,4 @@
 		nvidia,int-mic-en-gpios = <&gpio 184 0>; /* gpio PX0 */
 		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
 	};
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
-	};
-
-	serial at 70006300 {
-		clock-frequency = <216000000>;
-	};
-
-	serial at 70006400 {
-		status = "disable";
-	};
-
-	sdhci at c8000000 {
-		status = "disable";
-	};
-
-	sdhci at c8000200 {
-		status = "disable";
-	};
-
-	sdhci at c8000400 {
-		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
-		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
-		power-gpios = <&gpio 70 0>; /* gpio PI6 */
-	};
-
-	sdhci at c8000600 {
-		support-8bit;
-	};
-
-	usb at c5004000 {
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
-	};
 };
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 5f9110a..0e371f9 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -4,11 +4,6 @@
 	compatible = "nvidia,tegra20";
 	interrupt-parent = <&intc>;
 
-	pmc {
-		compatible = "nvidia,tegra20-pmc";
-		reg = <0x7000e400 0x400>;
-	};
-
 	intc: interrupt-controller {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
@@ -17,12 +12,6 @@
 		       0x50040100 0x0100>;
 	};
 
-	pmu {
-		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 56 0x04
-			      0 57 0x04>;
-	};
-
 	apbdma: dma {
 		compatible = "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1200>;
@@ -44,55 +33,9 @@
 			      0 119 0x04>;
 	};
 
-	i2c at 7000c000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "nvidia,tegra20-i2c";
-		reg = <0x7000c000 0x100>;
-		interrupts = <0 38 0x04>;
-	};
-
-	i2c at 7000c400 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "nvidia,tegra20-i2c";
-		reg = <0x7000c400 0x100>;
-		interrupts = <0 84 0x04>;
-	};
-
-	i2c at 7000c500 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "nvidia,tegra20-i2c";
-		reg = <0x7000c500 0x100>;
-		interrupts = <0 92 0x04>;
-	};
-
-	i2c at 7000d000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "nvidia,tegra20-i2c-dvc";
-		reg = <0x7000d000 0x200>;
-		interrupts = <0 53 0x04>;
-	};
-
-	tegra_i2s1: i2s at 70002800 {
-		compatible = "nvidia,tegra20-i2s";
-		reg = <0x70002800 0x200>;
-		interrupts = <0 13 0x04>;
-		nvidia,dma-request-selector = <&apbdma 2>;
-	};
-
-	tegra_i2s2: i2s at 70002a00 {
-		compatible = "nvidia,tegra20-i2s";
-		reg = <0x70002a00 0x200>;
-		interrupts = <0 3 0x04>;
-		nvidia,dma-request-selector = <&apbdma 1>;
-	};
-
-	das {
-		compatible = "nvidia,tegra20-das";
-		reg = <0x70000c00 0x80>;
+	ahb {
+		compatible = "nvidia,tegra20-ahb";
+		reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
 	};
 
 	gpio: gpio {
@@ -119,6 +62,25 @@
 		       0x70000868 0xa8>; /* Pad control registers */
 	};
 
+	das {
+		compatible = "nvidia,tegra20-das";
+		reg = <0x70000c00 0x80>;
+	};
+
+	tegra_i2s1: i2s at 70002800 {
+		compatible = "nvidia,tegra20-i2s";
+		reg = <0x70002800 0x200>;
+		interrupts = <0 13 0x04>;
+		nvidia,dma-request-selector = <&apbdma 2>;
+	};
+
+	tegra_i2s2: i2s at 70002a00 {
+		compatible = "nvidia,tegra20-i2s";
+		reg = <0x70002a00 0x200>;
+		interrupts = <0 3 0x04>;
+		nvidia,dma-request-selector = <&apbdma 1>;
+	};
+
 	serial at 70006000 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
@@ -154,35 +116,61 @@
 		interrupts = <0 91 0x04>;
 	};
 
-	emc {
+	i2c at 7000c000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "nvidia,tegra20-emc";
-		reg = <0x7000f400 0x200>;
+		compatible = "nvidia,tegra20-i2c";
+		reg = <0x7000c000 0x100>;
+		interrupts = <0 38 0x04>;
 	};
 
-	sdhci at c8000000 {
-		compatible = "nvidia,tegra20-sdhci";
-		reg = <0xc8000000 0x200>;
-		interrupts = <0 14 0x04>;
+	i2c at 7000c400 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra20-i2c";
+		reg = <0x7000c400 0x100>;
+		interrupts = <0 84 0x04>;
 	};
 
-	sdhci at c8000200 {
-		compatible = "nvidia,tegra20-sdhci";
-		reg = <0xc8000200 0x200>;
-		interrupts = <0 15 0x04>;
+	i2c at 7000c500 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra20-i2c";
+		reg = <0x7000c500 0x100>;
+		interrupts = <0 92 0x04>;
 	};
 
-	sdhci at c8000400 {
-		compatible = "nvidia,tegra20-sdhci";
-		reg = <0xc8000400 0x200>;
-		interrupts = <0 19 0x04>;
+	i2c at 7000d000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra20-i2c-dvc";
+		reg = <0x7000d000 0x200>;
+		interrupts = <0 53 0x04>;
 	};
 
-	sdhci at c8000600 {
-		compatible = "nvidia,tegra20-sdhci";
-		reg = <0xc8000600 0x200>;
-		interrupts = <0 31 0x04>;
+	pmc {
+		compatible = "nvidia,tegra20-pmc";
+		reg = <0x7000e400 0x400>;
+	};
+
+	mc {
+		compatible = "nvidia,tegra20-mc";
+		reg = <0x7000f000 0x024
+		       0x7000f03c 0x3c4>;
+		interrupts = <0 77 0x04>;
+	};
+
+	gart {
+		compatible = "nvidia,tegra20-gart";
+		reg = <0x7000f024 0x00000018	/* controller registers */
+		       0x58000000 0x02000000>;	/* GART aperture */
+	};
+
+	emc {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra20-emc";
+		reg = <0x7000f400 0x200>;
 	};
 
 	usb at c5000000 {
@@ -207,21 +195,33 @@
 		phy_type = "utmi";
 	};
 
-	ahb {
-		compatible = "nvidia,tegra20-ahb";
-		reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
+	sdhci at c8000000 {
+		compatible = "nvidia,tegra20-sdhci";
+		reg = <0xc8000000 0x200>;
+		interrupts = <0 14 0x04>;
 	};
 
-	mc {
-		compatible = "nvidia,tegra20-mc";
-		reg = <0x7000f000 0x024
-		       0x7000f03c 0x3c4>;
-		interrupts = <0 77 0x04>;
+	sdhci at c8000200 {
+		compatible = "nvidia,tegra20-sdhci";
+		reg = <0xc8000200 0x200>;
+		interrupts = <0 15 0x04>;
 	};
 
-	gart {
-		compatible = "nvidia,tegra20-gart";
-		reg = <0x7000f024 0x00000018	/* controller registers */
-		       0x58000000 0x02000000>;	/* GART aperture */
+	sdhci at c8000400 {
+		compatible = "nvidia,tegra20-sdhci";
+		reg = <0xc8000400 0x200>;
+		interrupts = <0 19 0x04>;
+	};
+
+	sdhci at c8000600 {
+		compatible = "nvidia,tegra20-sdhci";
+		reg = <0xc8000600 0x200>;
+		interrupts = <0 31 0x04>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 56 0x04
+			      0 57 0x04>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index ea829f5..9fb47ad 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -4,11 +4,6 @@
 	compatible = "nvidia,tegra30";
 	interrupt-parent = <&intc>;
 
-	pmc {
-		compatible = "nvidia,tegra20-pmc", "nvidia,tegra30-pmc";
-		reg = <0x7000e400 0x400>;
-	};
-
 	intc: interrupt-controller {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
@@ -17,14 +12,6 @@
 		       0x50040100 0x0100>;
 	};
 
-	pmu {
-		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 144 0x04
-			      0 145 0x04
-			      0 146 0x04
-			      0 147 0x04>;
-	};
-
 	apbdma: dma {
 		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1400>;
@@ -62,44 +49,9 @@
 			      0 143 0x04>;
 	};
 
-	i2c at 7000c000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible =  "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
-		reg = <0x7000c000 0x100>;
-		interrupts = <0 38 0x04>;
-	};
-
-	i2c at 7000c400 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
-		reg = <0x7000c400 0x100>;
-		interrupts = <0 84 0x04>;
-	};
-
-	i2c at 7000c500 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
-		reg = <0x7000c500 0x100>;
-		interrupts = <0 92 0x04>;
-	};
-
-	i2c at 7000c700 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
-		reg = <0x7000c700 0x100>;
-		interrupts = <0 120 0x04>;
-	};
-
-	i2c at 7000d000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
-		reg = <0x7000d000 0x100>;
-		interrupts = <0 53 0x04>;
+	ahb: ahb {
+		compatible = "nvidia,tegra30-ahb";
+		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
 	};
 
 	gpio: gpio {
@@ -119,6 +71,12 @@
 		interrupt-controller;
 	};
 
+	pinmux: pinmux {
+		compatible = "nvidia,tegra30-pinmux";
+		reg = <0x70000868 0xd0    /* Pad control registers */
+		       0x70003000 0x3e0>; /* Mux registers */
+	};
+
 	serial at 70006000 {
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
@@ -154,34 +112,68 @@
 		interrupts = <0 91 0x04>;
 	};
 
-	sdhci at 78000000 {
-		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
-		reg = <0x78000000 0x200>;
-		interrupts = <0 14 0x04>;
+	i2c at 7000c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible =  "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000c000 0x100>;
+		interrupts = <0 38 0x04>;
 	};
 
-	sdhci at 78000200 {
-		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
-		reg = <0x78000200 0x200>;
-		interrupts = <0 15 0x04>;
+	i2c at 7000c400 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000c400 0x100>;
+		interrupts = <0 84 0x04>;
 	};
 
-	sdhci at 78000400 {
-		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
-		reg = <0x78000400 0x200>;
-		interrupts = <0 19 0x04>;
+	i2c at 7000c500 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000c500 0x100>;
+		interrupts = <0 92 0x04>;
 	};
 
-	sdhci at 78000600 {
-		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
-		reg = <0x78000600 0x200>;
-		interrupts = <0 31 0x04>;
+	i2c at 7000c700 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000c700 0x100>;
+		interrupts = <0 120 0x04>;
 	};
 
-	pinmux: pinmux {
-		compatible = "nvidia,tegra30-pinmux";
-		reg = <0x70000868 0xd0    /* Pad control registers */
-		       0x70003000 0x3e0>; /* Mux registers */
+	i2c at 7000d000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000d000 0x100>;
+		interrupts = <0 53 0x04>;
+	};
+
+	pmc {
+		compatible = "nvidia,tegra20-pmc", "nvidia,tegra30-pmc";
+		reg = <0x7000e400 0x400>;
+	};
+
+	mc {
+		compatible = "nvidia,tegra30-mc";
+		reg = <0x7000f000 0x010
+		       0x7000f03c 0x1b4
+		       0x7000f200 0x028
+		       0x7000f284 0x17c>;
+		interrupts = <0 77 0x04>;
+	};
+
+	smmu {
+		compatible = "nvidia,tegra30-smmu";
+		reg = <0x7000f010 0x02c
+		       0x7000f1f0 0x010
+		       0x7000f228 0x05c>;
+		nvidia,#asids = <4>;		/* # of ASIDs */
+		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,ahb = <&ahb>;
 	};
 
 	ahub {
@@ -226,27 +218,35 @@
 		};
 	};
 
-	ahb: ahb {
-		compatible = "nvidia,tegra30-ahb";
-		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
+	sdhci at 78000000 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000000 0x200>;
+		interrupts = <0 14 0x04>;
 	};
 
-	mc {
-		compatible = "nvidia,tegra30-mc";
-		reg = <0x7000f000 0x010
-		       0x7000f03c 0x1b4
-		       0x7000f200 0x028
-		       0x7000f284 0x17c>;
-		interrupts = <0 77 0x04>;
+	sdhci at 78000200 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000200 0x200>;
+		interrupts = <0 15 0x04>;
 	};
 
-	smmu {
-		compatible = "nvidia,tegra30-smmu";
-		reg = <0x7000f010 0x02c
-		       0x7000f1f0 0x010
-		       0x7000f228 0x05c>;
-		nvidia,#asids = <4>;		/* # of ASIDs */
-		dma-window = <0 0x40000000>;	/* IOVA start & length */
-		nvidia,ahb = <&ahb>;
+	sdhci at 78000400 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000400 0x200>;
+		interrupts = <0 19 0x04>;
+	};
+
+	sdhci at 78000600 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000600 0x200>;
+		interrupts = <0 31 0x04>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 144 0x04
+			      0 145 0x04
+			      0 146 0x04
+			      0 147 0x04>;
 	};
 };
-- 
1.7.0.4
