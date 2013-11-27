From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 27 Nov 2013 17:27:45 +0900
Subject: [PATCH 01/04] ARM: shmobile: r7s72100 GPIO and PINCTRL device nodes
In-Reply-To: <20131127082736.20015.21303.sendpatchset@w520>
References: <20131127082736.20015.21303.sendpatchset@w520>
Message-ID: <20131127082745.20015.57024.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add support for r7s72100 PFC and GPIO device nodes port0 -> port11
and jtagport0.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r7s72100.dtsi |  154 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

--- 0001/arch/arm/boot/dts/r7s72100.dtsi
+++ work/arch/arm/boot/dts/r7s72100.dtsi	2013-11-27 16:06:36.000000000 +0900
@@ -14,6 +14,22 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		gpio0 = &port0;
+		gpio1 = &port1;
+		gpio2 = &port2;
+		gpio3 = &port3;
+		gpio4 = &port4;
+		gpio5 = &port5;
+		gpio6 = &port6;
+		gpio7 = &port7;
+		gpio8 = &port8;
+		gpio9 = &port9;
+		gpio10 = &port10;
+		gpio11 = &port11;
+		gpio12 = &jtagport0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -33,4 +49,142 @@
 		reg = <0xe8201000 0x1000>,
 			<0xe8202000 0x1000>;
 	};
+
+	pfc: pfc at fcfe3300 {
+		compatible = "renesas,pfc-r7s72100";
+		reg = <0xfcfe3300 0x400>, /* PM, PMC, PFC, PFCE */
+		  	  <0xfcfe3a00 0x100>, /* PFCAE */
+			  <0xfcfe7000 0x300>, /* PIBC, PBDC, PIPC */
+			  <0xfcfe7b40 0x04>, /* JPMC */
+			  <0xfcfe7b90 0x04>, /* JPMCSR */
+			  <0xfcfe7f00 0x04>; /* JPIBC */
+	};
+
+	port0: gpio at fcfe3100 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3100 0x4>, /* PSR */
+		  	  <0xfcfe3200 0x2>, /* PPR */
+			  <0xfcfe3800 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 0 6>;
+	};
+
+	port1: gpio at fcfe3104 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3104 0x4>, /* PSR */
+		  	  <0xfcfe3204 0x2>, /* PPR */
+			  <0xfcfe3804 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 16 16>;
+	};
+
+	port2: gpio at fcfe3108 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3108 0x4>, /* PSR */
+		  	  <0xfcfe3208 0x2>, /* PPR */
+			  <0xfcfe3808 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 32 16>;
+	};
+
+	port3: gpio at fcfe310c {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe310c 0x4>, /* PSR */
+		  	  <0xfcfe320c 0x2>, /* PPR */
+			  <0xfcfe380c 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 48 16>;
+	};
+
+	port4: gpio at fcfe3110 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3110 0x4>, /* PSR */
+		  	  <0xfcfe3210 0x2>, /* PPR */
+			  <0xfcfe3810 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 64 16>;
+	};
+
+	port5: gpio at fcfe3114 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3114 0x4>, /* PSR */
+		  	  <0xfcfe3214 0x2>, /* PPR */
+			  <0xfcfe3814 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 80 11>;
+	};
+
+	port6: gpio at fcfe3118 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3118 0x4>, /* PSR */
+		  	  <0xfcfe3218 0x2>, /* PPR */
+			  <0xfcfe3818 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 96 16>;
+	};
+
+	port7: gpio at fcfe311c {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe311c 0x4>, /* PSR */
+		  	  <0xfcfe321c 0x2>, /* PPR */
+			  <0xfcfe381c 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 112 16>;
+	};
+
+	port8: gpio at fcfe3120 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3120 0x4>, /* PSR */
+		  	  <0xfcfe3220 0x2>, /* PPR */
+			  <0xfcfe3820 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 128 16>;
+	};
+
+	port9: gpio at fcfe3124 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3124 0x4>, /* PSR */
+		  	  <0xfcfe3224 0x2>, /* PPR */
+			  <0xfcfe3824 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 144 8>;
+	};
+
+	port10: gpio at fcfe3128 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3128 0x4>, /* PSR */
+		  	  <0xfcfe3228 0x2>, /* PPR */
+			  <0xfcfe3828 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 160 16>;
+	};
+
+	port11: gpio at fcfe312c {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe312c 0x4>, /* PSR */
+		  	  <0xfcfe322c 0x2>, /* PPR */
+			  <0xfcfe382c 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 176 16>;
+	};
+
+	jtagport0: gpio at fcfe7b20 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe7b20 0x2>; /* JPPR */
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 192 2>;
+	};
 };
