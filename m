From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:57:56 +0900
Subject: [PATCH 04/13] ARM: shmobile: r8a73a4: Add MSTP clock assignments to DT
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <662dd64ff0691a0f2ab103448295df05dc026d5d.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Assigns clocks to dmac, i2c*, cmt1, thermal, scif*, sdhi*, and mmcif*.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index a1adfe4..fdcca5d 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -88,6 +88,7 @@
 					"ch8", "ch9", "ch10", "ch11",
 					"ch12", "ch13", "ch14", "ch15",
 					"ch16", "ch17", "ch18", "ch19";
+			clocks = <&mstp2_clks R8A73A4_CLK_DMAC>;
 		};
 	};
 
@@ -120,6 +121,7 @@
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x428>;
 		interrupts = <0 179 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A73A4_CLK_IIC5>;
 
 		status = "disabled";
 	};
@@ -128,6 +130,8 @@
 		compatible = "renesas,cmt-48-r8a73a4", "renesas,cmt-48-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
+		clock-names = "fck";
 
 		renesas,channels-mask = <0xff>;
 
@@ -211,6 +215,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
 			 <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A73A4_CLK_THERMAL>;
 	};
 
 	i2c0: i2c at e6500000 {
@@ -219,6 +224,7 @@
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x428>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC0>;
 		status = "disabled";
 	};
 
@@ -228,6 +234,7 @@
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x428>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC1>;
 		status = "disabled";
 	};
 
@@ -237,6 +244,7 @@
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6520000 0 0x428>;
 		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC2>;
 		status = "disabled";
 	};
 
@@ -246,6 +254,7 @@
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6530000 0 0x428>;
 		interrupts = <0 177 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A73A4_CLK_IIC3>;
 		status = "disabled";
 	};
 
@@ -255,6 +264,7 @@
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6540000 0 0x428>;
 		interrupts = <0 178 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A73A4_CLK_IIC4>;
 		status = "disabled";
 	};
 
@@ -264,6 +274,7 @@
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6550000 0 0x428>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC6>;
 		status = "disabled";
 	};
 
@@ -273,6 +284,7 @@
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6560000 0 0x428>;
 		interrupts = <0 185 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC7>;
 		status = "disabled";
 	};
 
@@ -282,6 +294,7 @@
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6570000 0 0x428>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A73A4_CLK_IIC8>;
 		status = "disabled";
 	};
 
@@ -289,6 +302,8 @@
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c20000 0 0x100>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB0>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -296,6 +311,8 @@
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c30000 0 0x100>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB1>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -303,6 +320,8 @@
 		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
 		reg = <0 0xe6c40000 0 0x100>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA0>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -310,6 +329,8 @@
 		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
 		reg = <0 0xe6c50000 0 0x100>;
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA1>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -317,6 +338,8 @@
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 0x100>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB2>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -324,6 +347,8 @@
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6cf0000 0 0x100>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB3>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -331,6 +356,7 @@
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee100000 0 0x100>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_SDHI0>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -339,6 +365,7 @@
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee120000 0 0x100>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_SDHI1>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -347,6 +374,7 @@
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_SDHI2>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -355,6 +383,7 @@
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF0>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -363,6 +392,7 @@
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF1>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
-- 
2.1.4
