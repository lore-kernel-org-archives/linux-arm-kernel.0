From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Mar 2013 17:21:19 -0600
Subject: [PATCH] ARM: tegra: add clocks property to sound nodes
Message-ID: <1364340079-3762-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Audio-related clocks need to be represented in the device tree. Update
bindings to describe which clocks are needed, and DT files to include
those clocks.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt   |    8 ++++++++
 .../devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt |    7 +++++++
 .../devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt    |    8 ++++++++
 .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt    |    8 ++++++++
 arch/arm/boot/dts/tegra20-harmony.dts                          |    3 +++
 arch/arm/boot/dts/tegra20-medcom-wide.dts                      |    3 +++
 arch/arm/boot/dts/tegra20-paz00.dts                            |    3 +++
 arch/arm/boot/dts/tegra20-plutux.dts                           |    3 +++
 arch/arm/boot/dts/tegra20-seaboard.dts                         |    3 +++
 arch/arm/boot/dts/tegra20-tec.dts                              |    3 +++
 arch/arm/boot/dts/tegra20-trimslice.dts                        |    3 +++
 arch/arm/boot/dts/tegra20-ventana.dts                          |    3 +++
 arch/arm/boot/dts/tegra20-whistler.dts                         |    3 +++
 arch/arm/boot/dts/tegra30-cardhu.dtsi                          |    3 +++
 14 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
index b77a97c..05ffecb 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
@@ -2,6 +2,11 @@ NVIDIA Tegra audio complex
 
 Required properties:
 - compatible : "nvidia,tegra-audio-alc5632"
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  "pll_a" (The Tegra clock of that name),
+  "pll_a_out0" (The Tegra clock of that name),
+  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,model : The user-visible name of this sound complex.
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
@@ -56,4 +61,7 @@ sound {
 
 	nvidia,i2s-controller = <&tegra_i2s1>;
 	nvidia,audio-codec = <&alc5632>;
+
+	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+	clock-names = "pll_a", "pll_a_out0", "mclk";
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt
index 04b14cf..ef1fe73 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt
@@ -2,6 +2,11 @@ NVIDIA Tegra audio complex for TrimSlice
 
 Required properties:
 - compatible : "nvidia,tegra-audio-trimslice"
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  "pll_a" (The Tegra clock of that name),
+  "pll_a_out0" (The Tegra clock of that name),
+  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,i2s-controller : The phandle of the Tegra I2S1 controller
 - nvidia,audio-codec : The phandle of the WM8903 audio codec
 
@@ -11,4 +16,6 @@ sound {
 	compatible = "nvidia,tegra-audio-trimslice";
 	nvidia,i2s-controller = <&tegra_i2s1>;
 	nvidia,audio-codec = <&codec>;
+	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+	clock-names = "pll_a", "pll_a_out0", "mclk";
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
index c4dd39c..d145106 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
@@ -2,6 +2,11 @@ NVIDIA Tegra audio complex
 
 Required properties:
 - compatible : "nvidia,tegra-audio-wm8753"
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  "pll_a" (The Tegra clock of that name),
+  "pll_a_out0" (The Tegra clock of that name),
+  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,model : The user-visible name of this sound complex.
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
@@ -50,5 +55,8 @@ sound {
 
 	nvidia,i2s-controller = <&i2s1>;
 	nvidia,audio-codec = <&wm8753>;
+
+	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+	clock-names = "pll_a", "pll_a_out0", "mclk";
 };
 
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
index d5b0da8..3bf722d 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
@@ -2,6 +2,11 @@ NVIDIA Tegra audio complex
 
 Required properties:
 - compatible : "nvidia,tegra-audio-wm8903"
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  "pll_a" (The Tegra clock of that name),
+  "pll_a_out0" (The Tegra clock of that name),
+  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,model : The user-visible name of this sound complex.
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
@@ -67,5 +72,8 @@ sound {
 	nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
 	nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
 	nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
+
+	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+	clock-names = "pll_a", "pll_a_out0", "mclk";
 };
 
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 1f79c0d..5fb0888 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -656,5 +656,8 @@
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
 		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
 		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index 52993a1..740ba7c 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -58,5 +58,8 @@
 
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 9db36da..43fd28b 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -501,5 +501,8 @@
 		nvidia,audio-codec = <&alc5632>;
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/tegra20-plutux.dts
index 2894800..7085ae5 100644
--- a/arch/arm/boot/dts/tegra20-plutux.dts
+++ b/arch/arm/boot/dts/tegra20-plutux.dts
@@ -52,5 +52,8 @@
 
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 715a8b8..4f810a5 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -808,5 +808,8 @@
 
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 185 0>; /* gpio PX1 */
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 402b210..9be175d 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -52,5 +52,8 @@
 
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 98f3e44..955bf49 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -363,5 +363,8 @@
 		compatible = "nvidia,tegra-audio-trimslice";
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&codec>;
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 4aef56f..3f8ae10 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -607,5 +607,8 @@
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
 		nvidia,int-mic-en-gpios = <&gpio 184 0>; /* gpio PX0 */
 		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 5762188..87e2d85 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -560,5 +560,8 @@
 
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&codec>;
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 3e2d210..11204e1 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -496,5 +496,8 @@
 
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+
+		clocks = <&tegra_car 184>, <&tegra_car 185>, <&tegra_car 120>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
-- 
1.7.10.4
