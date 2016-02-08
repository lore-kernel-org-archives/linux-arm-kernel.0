From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 09 Feb 2016 01:57:22 +0300
Subject: [PATCH 1/5] ARM: dts: r8a7794: add audio clocks
In-Reply-To: <4253511.vvGjIdOnb6@wasted.cogentembedded.com>
References: <4253511.vvGjIdOnb6@wasted.cogentembedded.com>
Message-ID: <1840385.PK7TPc1Pyy@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the external audio clocks (signals AUDIO_CLK[ABC]) required by
the sound driver. Boards that provide audio clocks need to override the
clock frequencies.

This patch is based on the commit 0d3dbde84a45 ("ARM: shmobile: r8a7791:
add  audio clock on DTSI").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -833,6 +833,30 @@
 			status = "disabled";
 		};
 
+		/*
+		 * The external audio clocks are configured  as 0 Hz fixed
+		 * frequency clocks by default.  Boards that provide audio
+		 * clocks should override them.
+		 */
+		audio_clka: audio_clka {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "audio_clka";
+		};
+		audio_clkb: audio_clkb {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "audio_clkb";
+		};
+		audio_clkc: audio_clkc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "audio_clkc";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at e6150000 {
 			compatible = "renesas,r8a7794-cpg-clocks",
