From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Nov 2012 14:13:18 +0900
Subject: [RFC 06/15] ARM: mach-shmobile: Add DT table of INTC for sh73a0
In-Reply-To: <1353302007-31045-1-git-send-email-horms@verge.net.au>
References: <1353302007-31045-1-git-send-email-horms@verge.net.au>
Message-ID: <1353302007-31045-7-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

--

v3
* As suggested by Tetsuyuki Kobayashi
  - Use arm,cortex-a9 for cpu at 0.compatible instead of
    arm,cortex-a8.

v2
* No change

fix
---
 arch/arm/boot/dts/sh73a0.dtsi |  810 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 810 insertions(+)
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
new file mode 100644
index 0000000..7d56345
--- /dev/null
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -0,0 +1,810 @@
+/*
+ * Device Tree Source for the SH73A0
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "renesas,sh73a0";
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		intcs: interrupt-controller at 0 {
+			compatible = "renesas,sh_intcs";
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			ranges;
+			group_size = <8>;
+
+			reg = <0xffd20000 0x200>,
+				<0xffd50000 0x200>,
+				<0xffd60000 0x200>;
+
+			PINTCS_PINT1:	intsrc1{ vector = <0x3a00>; };
+			PINTCS_PINT2:	intsrc2{ vector = <0x3a20>; };
+			RTDMAC_0_DEI0:	intsrc3{ vector = <0x3c00>; };
+			RTDMAC_0_DEI1:	intsrc4{ vector = <0x3c20>; };
+			RTDMAC_0_DEI2:	intsrc5{ vector = <0x3c40>; };
+			RTDMAC_0_DEI3:	intsrc6{ vector = <0x3c60>; };
+			CEU:	intsrc7{ vector = <0x3c80>; };
+			MFI:	intsrc8{ vector = <0x3d00>; };
+			BBIF2:	intsrc9{ vector = <0x3d60>; };
+			VPU:	intsrc10{ vector = <0x3d80>; };
+			TSIF1:	intsrc11{ vector = <0x3da0>; };
+			_3DG_SGX543:	intsrc12{ vector = <0x3de0>; };
+			_2DDMAC_2DDM0:	intsrc13{ vector = <0x3e00>; };
+			RTDMAC_1_DEI4:	intsrc14{ vector = <0x3f80>; };
+			RTDMAC_1_DEI5:	intsrc15{ vector = <0x3fa0>; };
+			RTDMAC_1_DADERR:	intsrc16{ vector = <0x3fc0>; };
+			KEYSC_KEY:	intsrc17{ vector = <0x3fe0>; };
+			VINT:	intsrc18{ vector = <0x4080>; };
+			MSIOF:	intsrc19{ vector = <0x4120>; };
+			TMU0_TUNI00:	intsrc20{ vector = <0x4280>; };
+			TMU0_TUNI01:	intsrc21{ vector = <0x42a0>; };
+			TMU0_TUNI02:	intsrc22{ vector = <0x42c0>; };
+			CMT0:	intsrc23{ vector = <0x4300>; };
+			TSIF0:	intsrc24{ vector = <0x4320>; };
+			CMT2:	intsrc25{ vector = <0x4340>; };
+			LMB:	intsrc26{ vector = <0x4360>; };
+			MSUG:	intsrc27{ vector = <0x4380>; };
+			MSU_MSU:	intsrc28{ vector = <0x43a0>; };
+			MSU_MSU2:	intsrc29{ vector = <0x43c0>; };
+			CTI:	intsrc30{ vector = <0x3800>; };
+			RWDT0:	intsrc31{ vector = <0x3840>; };
+			ICB:	intsrc32{ vector = <0x3880>; };
+			PEP:	intsrc33{ vector = <0x38a0>; };
+			ASA:	intsrc34{ vector = <0x38c0>; };
+			JPU_JPEG:	intsrc35{ vector = <0x3960>; };
+			LCDC:	intsrc36{ vector = <0x3980>; };
+			LCRC:	intsrc37{ vector = <0x39a0>; };
+			RTDMAC_2_DEI6:	intsrc38{ vector = <0x4700>; };
+			RTDMAC_2_DEI7:	intsrc39{ vector = <0x4720>; };
+			RTDMAC_2_DEI8:	intsrc40{ vector = <0x4740>; };
+			RTDMAC_2_DEI9:	intsrc41{ vector = <0x4760>; };
+			RTDMAC_3_DEI10:	intsrc42{ vector = <0x4780>; };
+			RTDMAC_3_DEI11:	intsrc43{ vector = <0x47a0>; };
+			FRC:	intsrc44{ vector = <0x4b00>; };
+			GCU:	intsrc45{ vector = <0x4b60>; };
+			LCDC1:	intsrc46{ vector = <0x4b80>; };
+			CSIRX:	intsrc47{ vector = <0x4ba0>; };
+			DSITX0_DSITX00:	intsrc48{ vector = <0x4bc0>; };
+			DSITX0_DSITX01:	intsrc49{ vector = <0x4be0>; };
+			SPU2_SPU0:	intsrc50{ vector = <0x4c00>; };
+			SPU2_SPU1:	intsrc51{ vector = <0x4c20>; };
+			FSI:	intsrc52{ vector = <0x4c40>; };
+			TMU1_TUNI10:	intsrc53{ vector = <0x4d00>; };
+			TMU1_TUNI11:	intsrc54{ vector = <0x4d20>; };
+			TMU1_TUNI12:	intsrc55{ vector = <0x4d40>; };
+			TSIF2:	intsrc56{ vector = <0x4d60>; };
+			CMT4:	intsrc57{ vector = <0x4d80>; };
+			MFIS2:	intsrc58{ vector = <0x4e00>; };
+			CPORTS2R:	intsrc59{ vector = <0x4e20>; };
+			TSG:	intsrc60{ vector = <0x4ee0>; };
+			DMASCH1:	intsrc61{ vector = <0x4f00>; };
+			SCUW:	intsrc62{ vector = <0x4f40>; };
+			VIO60:	intsrc63{ vector = <0x4f60>; };
+			VIO61:	intsrc64{ vector = <0x4f80>; };
+			CEU21:	intsrc65{ vector = <0x4fa0>; };
+			CSI21:	intsrc66{ vector = <0x4fe0>; };
+			DSITX1_DSITX10:	intsrc67{ vector = <0x5000>; };
+			DSITX1_DSITX11:	intsrc68{ vector = <0x5020>; };
+			DISP:	intsrc69{ vector = <0x5040>; };
+			DSRV:	intsrc70{ vector = <0x5060>; };
+			EMUX2_EMUX20I:	intsrc71{ vector = <0x5080>; };
+			EMUX2_EMUX21I:	intsrc72{ vector = <0x50a0>; };
+			MSTIF0_MST00I:	intsrc73{ vector = <0x50c0>; };
+			MSTIF0_MST01I:	intsrc74{ vector = <0x50e0>; };
+			MSTIF1_MST10I:	intsrc75{ vector = <0x5100>; };
+			MSTIF1_MST11I:	intsrc76{ vector = <0x5120>; };
+			SPUV:	intsrc77 { vector = <0x5700>; };
+
+			/* group */
+			RTDMAC_0: intc_group0 {
+				group = <&RTDMAC_0_DEI0 &RTDMAC_0_DEI1
+						&RTDMAC_0_DEI2 &RTDMAC_0_DEI3>;
+			};
+
+			RTDMAC_1: intc_group1 {
+				group = <&RTDMAC_1_DEI4 &RTDMAC_1_DEI5
+						&RTDMAC_1_DADERR>;
+			};
+
+			RTDMAC_2: intc_group2 {
+				group = <&RTDMAC_2_DEI6 &RTDMAC_2_DEI7
+						&RTDMAC_2_DEI8 &RTDMAC_2_DEI9>;
+			};
+
+			RTDMAC_3: intc_group3 {
+				group = <&RTDMAC_3_DEI10 &RTDMAC_3_DEI11>;
+			};
+
+			TMU1: intc_group4 {
+				group = <&TMU1_TUNI12 &TMU1_TUNI11 &TMU1_TUNI10>;
+			};
+
+			DSITX0: intc_group5 {
+				group = <&DSITX0_DSITX00 &DSITX0_DSITX01>;
+			};
+			SPU2: intc_group6 {
+				group = <&SPU2_SPU0 &SPU2_SPU1>;
+			};
+			MSU: intc_group7 {
+				group = <&MSU_MSU &MSU_MSU2>;
+			};
+
+			intc_vectors {
+				vector_table = <&PINTCS_PINT1 &PINTCS_PINT2 &RTDMAC_0_DEI0
+						&RTDMAC_0_DEI1 &RTDMAC_0_DEI2 &RTDMAC_0_DEI3
+						&CEU &MFI &BBIF2 &VPU &TSIF1 &_3DG_SGX543
+						&_2DDMAC_2DDM0 &RTDMAC_1_DEI4 &RTDMAC_1_DEI5
+						&RTDMAC_1_DADERR &KEYSC_KEY &VINT &MSIOF
+						&TMU0_TUNI00 &TMU0_TUNI01 &TMU0_TUNI02
+						&CMT0 &TSIF0 &CMT2 &LMB &MSUG &MSU_MSU &MSU_MSU2
+						&CTI &RWDT0 &ICB &PEP &ASA &JPU_JPEG
+						&LCDC &LCRC
+						&RTDMAC_2_DEI6 &RTDMAC_2_DEI7 &RTDMAC_2_DEI8
+						&RTDMAC_2_DEI9	&RTDMAC_3_DEI10 &RTDMAC_3_DEI11
+						&FRC &GCU &LCDC1 &CSIRX &DSITX0_DSITX00
+						&DSITX0_DSITX01 &SPU2_SPU0 &SPU2_SPU1 &FSI
+						&TMU1_TUNI10 &TMU1_TUNI11 &TMU1_TUNI12 &TSIF2
+						&CMT4 &MFIS2 &CPORTS2R &TSG &DMASCH1 &SCUW &VIO60
+						&VIO61 &CEU21 &CSI21
+						&DSITX1_DSITX10 &DSITX1_DSITX11 &DISP &DSRV
+						&EMUX2_EMUX20I &EMUX2_EMUX21I &MSTIF0_MST00I
+						&MSTIF0_MST01I &MSTIF1_MST10I &MSTIF1_MST11I
+						&SPUV>;
+			};
+
+			intc_mask_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_mask0 {
+					reg = <0xffd20184 1>, <0xffd201c4 1>;
+					reginfo = <0 0 0 &CEU 0 0 0 0>;
+				};
+
+				intc_mask1 {
+					reg = <0xffd20188 1>, <0xffd201c8 1>;
+					reginfo = <0 0 0 &VPU &BBIF2 0 0 &MFI>;
+				};
+
+				intc_mask2 {
+					reg = <0xffd2018c 1>, <0xffd201cc 1>;
+					reginfo = <0 0 0 &_2DDMAC_2DDM0 0 &ASA &PEP &ICB>;
+				};
+
+				intc_mask3 {
+					reg = <0xffd20190 1>, <0xffd201d0 1>;
+					reginfo = <0 0 0 &CTI &JPU_JPEG 0 &LCRC &LCDC>;
+				};
+
+				intc_mask4 {
+					reg = <0xffd20194 1>, <0xffd201d4 1>;
+					reginfo = <&KEYSC_KEY &RTDMAC_1_DADERR &RTDMAC_1_DEI5
+							&RTDMAC_1_DEI4 &RTDMAC_0_DEI3 &RTDMAC_0_DEI2
+							&RTDMAC_0_DEI1 &RTDMAC_0_DEI0>;
+				};
+
+				intc_mask5 {
+					reg = <0xffd20198 1>, <0xffd201d8 1>;
+					reginfo = <0 0 &MSIOF 0 &_3DG_SGX543 0 0 0>;
+				};
+
+				intc_mask6 {
+					reg = <0xffd2019c 1>, <0xffd201dc 1>;
+					reginfo = <0 &TMU0_TUNI02 &TMU0_TUNI01 &TMU0_TUNI00
+							0 0 0 0>;
+				};
+
+				intc_mask7 {
+					reg = <0xffd201a0 1>, <0xffd201e0 1>;
+					reginfo = <0 0 0 0 0 &MSU_MSU &MSU_MSU2 &MSUG>;
+				};
+
+				intc_mask8 {
+					reg = <0xffd201a4 1>, <0xffd201e4 1>;
+					reginfo = <0 &RWDT0 &CMT2 &CMT0 0 0 0 0>;
+				};
+
+				intc_mask9 {
+					reg = <0xffd201ac 1>, <0xffd201ec 1>;
+					reginfo = <0 0 0 0 0 &TSIF1 &LMB &TSIF0>;
+				};
+
+				intc_mask10 {
+					reg = <0xffd201b0 1>, <0xffd201f0 1>;
+					reginfo = <0 0 0 0 0 0 &PINTCS_PINT2 &PINTCS_PINT1>;
+				};
+
+				intc_mask11 {
+					reg = <0xffd50180 1>, <0xffd501c0 1>;
+					reginfo = <&RTDMAC_2_DEI6 &RTDMAC_2_DEI7 &RTDMAC_2_DEI8
+							&RTDMAC_2_DEI9 &RTDMAC_3_DEI10 &RTDMAC_3_DEI11 0 0>;
+				};
+
+				intc_mask12 {
+					reg = <0xffd50190 1>, <0xffd501d0 1>;
+					reginfo = <&FRC 0 0 &GCU &LCDC1 &CSIRX &DSITX0_DSITX00
+							&DSITX0_DSITX01>;
+				};
+
+				intc_mask13 {
+					reg = <0xffd50194 1>, <0xffd501d4 1>;
+					reginfo = <&SPU2_SPU0 &SPU2_SPU1 &FSI 0 0 0 0 0>;
+				};
+
+				intc_mask14 {
+					reg = <0xffd50198 1>, <0xffd501d8 1>;
+					reginfo = <&TMU1_TUNI10 &TMU1_TUNI11 &TMU1_TUNI12 0
+							&TSIF2 &CMT4 0 0>;
+				};
+
+				intc_mask15 {
+					reg = <0xffd5019c 1>, <0xffd501dc 1>;
+					reginfo = <&MFIS2 &CPORTS2R 0 0 0 0 0 &TSG>;
+				};
+
+				intc_mask16 {
+					reg = <0xffd501a0 1>, <0xffd501e0 1>;
+					reginfo = <&DMASCH1 0 &SCUW &VIO60 &VIO61 &CEU21 0 &CSI21>;
+				};
+
+				intc_mask17 {
+					reg = <0xffd501a4 1>, <0xffd501e4 1>;
+					reginfo = <&DSITX1_DSITX10 &DSITX1_DSITX11 &DISP &DSRV
+							&EMUX2_EMUX20I &EMUX2_EMUX21I &MSTIF0_MST00I
+							&MSTIF0_MST01I>;
+				};
+
+				intc_mask18 {
+					reg = <0xffd501a8 1>, <0xffd501e8 1>;
+					reginfo = <&MSTIF0_MST00I &MSTIF0_MST01I 0 0 0 0 0 0>;
+				};
+
+				intc_mask19 {
+					reg = <0xffd60180 1>, <0xffd601c0 1>;
+					reginfo = <&SPUV 0 0 0 0 0 0 0>;
+				};
+			};
+
+			intc_prio_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_prio0 {
+					reg = <0xffd20000 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&CTI 0 &_2DDMAC_2DDM0 &ICB>;
+				};
+
+				intc_prio1 {
+					reg = <0xffd20004 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&JPU_JPEG &LCDC 0 &LCRC>;
+				};
+
+				intc_prio2 {
+					reg = <0xffd20008 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&BBIF2 0 0 0>;
+				};
+
+				intc_prio3 {
+					reg = <0xffd2000c 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&PINTCS_PINT1 &PINTCS_PINT2 0 0>;
+				};
+
+				intc_prio4 {
+					reg = <0xffd20010 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&RTDMAC_0 &CEU &MFI &VPU>;
+				};
+
+				intc_prio5 {
+					reg = <0xffd20014 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&KEYSC_KEY &RTDMAC_1 &CMT2 &CMT0>;
+				};
+
+				intc_prio6 {
+					reg = <0xffd20018 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&TMU0_TUNI00 &TMU0_TUNI01 &TMU0_TUNI02 &TSIF1>;
+				};
+
+				intc_prio7 {
+					reg = <0xffd2001c 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&VINT 0 0 0>;
+				};
+
+				intc_prio8 {
+					reg = <0xffd20020 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <0 &MSIOF &TSIF0 0>;
+				};
+
+				intc_prio9 {
+					reg = <0xffd20024 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <0 &_3DG_SGX543 &MSUG &MSU>;
+				};
+
+				intc_prio10 {
+					reg = <0xffd20028 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <0 &ASA &LMB &PEP>;
+				};
+
+				intc_prio11 {
+					reg = <0xffd20030 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <0 0 0 &RWDT0>;
+				};
+
+				intc_prio12 {
+					reg = <0xffd50000 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&RTDMAC_2 0 0 0>;
+				};
+
+				intc_prio13 {
+					reg = <0xffd50004 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&RTDMAC_3 0 0 0>;
+				};
+
+				intc_prio14 {
+					reg = <0xffd50020 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&FRC 0 0 0>;
+				};
+
+				intc_prio15 {
+					reg = <0xffd50024 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&LCDC1 &CSIRX &DSITX0 0>;
+				};
+
+				intc_prio16 {
+					reg = <0xffd50028 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&SPU2 0 &FSI 0>;
+				};
+
+				intc_prio17 {
+					reg = <0xffd50030 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&TMU1 0 0 &TSIF2>;
+				};
+
+				intc_prio18 {
+					reg = <0xffd50034 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&CMT4 0 0 0>;
+				};
+
+				intc_prio19 {
+					reg = <0xffd50038 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&MFIS2 &CPORTS2R 0 0>;
+				};
+
+				intc_prio20 {
+					reg = <0xffd50040 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&DMASCH1 0 &SCUW &VIO60>;
+				};
+
+				intc_prio21 {
+					reg = <0xffd50044 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&VIO61 &CEU21 0 &CSI21>;
+				};
+
+				intc_prio22 {
+					reg = <0xffd50048 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&DSITX1_DSITX10 &DSITX1_DSITX11
+							&DISP &DSRV>;
+				};
+
+				intc_prio23 {
+					reg = <0xffd5004c 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&EMUX2_EMUX20I &EMUX2_EMUX21I
+							&MSTIF0_MST00I &MSTIF0_MST01I>;
+				};
+
+				intc_prio24 {
+					reg = <0xffd50050 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&MSTIF1_MST10I &MSTIF1_MST11I 0 0>;
+				};
+
+				intc_prio25 {
+					reg = <0xffd60000 2>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&SPUV 0 0 0>;
+				};
+			};
+		};
+
+		intca_irq_pins: interrupt-controller at 1 {
+			compatible = "renesas,sh_intca_irq_pins";
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			reg = <0xe6900000 0x6c>;
+
+			IRQ0:	intsrc1 { vector = <0x4800>; };
+			IRQ1:	intsrc2 { vector = <0x4820>; };
+			IRQ2:	intsrc3 { vector = <0x4840>; };
+			IRQ3:	intsrc4 { vector = <0x4860>; };
+			IRQ4:	intsrc5 { vector = <0x4880>; };
+			IRQ5:	intsrc6 { vector = <0x48a0>; };
+			IRQ6:	intsrc7 { vector = <0x48c0>; };
+			IRQ7:	intsrc8 { vector = <0x48e0>; };
+			IRQ8:	intsrc9 { vector = <0x4900>; };
+			IRQ9:	intsrc10 { vector = <0x4920>; };
+			IRQ10:	intsrc11 { vector = <0x4940>; };
+			IRQ11:	intsrc12 { vector = <0x4960>; };
+			IRQ12:	intsrc13 { vector = <0x4980>; };
+			IRQ13:	intsrc14 { vector = <0x49a0>; };
+			IRQ14:	intsrc15 { vector = <0x49c0>; };
+			IRQ15:	intsrc16 { vector = <0x49e0>; };
+			IRQ16:	intsrc17 { vector = <0x7800>; };
+			IRQ17:	intsrc18 { vector = <0x7820>; };
+			IRQ18:	intsrc19 { vector = <0x7840>; };
+			IRQ19:	intsrc20 { vector = <0x7860>; };
+			IRQ20:	intsrc21 { vector = <0x7880>; };
+			IRQ21:	intsrc22 { vector = <0x78a0>; };
+			IRQ22:	intsrc23 { vector = <0x78c0>; };
+			IRQ23:	intsrc24 { vector = <0x78e0>; };
+			IRQ24:	intsrc25 { vector = <0x7900>; };
+			IRQ25:	intsrc26 { vector = <0x7920>; };
+			IRQ26:	intsrc27 { vector = <0x7940>; };
+			IRQ27:	intsrc28 { vector = <0x7960>; };
+			IRQ28:	intsrc29 { vector = <0x7980>; };
+			IRQ29:	intsrc30 { vector = <0x79a0>; };
+			IRQ30:	intsrc31 { vector = <0x79c0>; };
+			IRQ31:	intsrc32 { vector = <0x79e0>; };
+
+			intc_vectors {
+				vector_table = <&IRQ0 &IRQ1 &IRQ2 &IRQ3 &IRQ4 &IRQ5
+								&IRQ6 &IRQ7 &IRQ8 &IRQ9 &IRQ10
+								&IRQ11 &IRQ12 &IRQ13 &IRQ14 &IRQ15
+								&IRQ16 &IRQ17 &IRQ18 &IRQ19 &IRQ20
+								&IRQ21 &IRQ22 &IRQ23 &IRQ24 &IRQ25
+								&IRQ26 &IRQ27 &IRQ28 &IRQ29 &IRQ30
+								&IRQ31>;
+			};
+
+			intc_mask_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_mask0 {
+					reg = <0xe6900040 1>, <0xe6900060 1>;
+					reginfo = <&IRQ0 &IRQ1 &IRQ2 &IRQ3 &IRQ4
+							&IRQ5 &IRQ6 &IRQ7>;
+				};
+
+				intc_mask1 {
+					reg = <0xe6900044 1>, <0xe6900064 1>;
+					reginfo = <&IRQ8 &IRQ9 &IRQ10 &IRQ11
+							&IRQ12 &IRQ13 &IRQ14 &IRQ15>;
+				};
+
+				intc_mask2 {
+					reg = <0xe6900048 1>, <0xe6900068 1>;
+					reginfo = <&IRQ16 &IRQ17 &IRQ18 &IRQ19
+							&IRQ20 &IRQ21 &IRQ22 &IRQ23>;
+				};
+
+				intc_mask3 {
+					reg = <0xe690004C 1>, <0xe690006C 1>;
+					reginfo = <&IRQ24 &IRQ25 &IRQ26 &IRQ27
+							&IRQ28 &IRQ29 &IRQ30 &IRQ31>;
+				};
+			};
+
+			intc_prio_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_prio0 {
+					reg = <0xe6900010 4>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&IRQ0 &IRQ1 &IRQ2 &IRQ3 &IRQ4 &IRQ5 &IRQ6 &IRQ7>;
+				};
+
+				intc_prio1 {
+					reg = <0xe6900014 4>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&IRQ8 &IRQ9 &IRQ10 &IRQ11
+							&IRQ12 &IRQ13 &IRQ14 &IRQ15>;
+				};
+
+				intc_prio2 {
+					reg = <0xe6900018 4>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&IRQ16 &IRQ17 &IRQ18 &IRQ19
+							&IRQ20 &IRQ21 &IRQ22 &IRQ23>;
+				};
+
+				intc_prio3 {
+					reg = <0xe690001C 4>, <0x0 0>;
+					field-width = <4>;
+					reginfo = <&IRQ24 &IRQ25 &IRQ26 &IRQ27
+							&IRQ28 &IRQ29 &IRQ30 &IRQ31>;
+				};
+			};
+
+			intc_sense_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_sense0 {
+					reg = <0xe6900000 4>;
+					field-width = <4>;
+					reginfo = <&IRQ0 &IRQ1 &IRQ2 &IRQ3 &IRQ4 &IRQ5 &IRQ6 &IRQ7>;
+				};
+
+				intc_sense1 {
+					reg = <0xe6900004 4>;
+					field-width = <4>;
+					reginfo = <&IRQ8 &IRQ9 &IRQ10 &IRQ11
+							&IRQ12 &IRQ13 &IRQ14 &IRQ15>;
+				};
+
+				intc_sense2 {
+					reg = <0xe6900008 4>;
+					field-width = <4>;
+					reginfo = <&IRQ16 &IRQ17 &IRQ18 &IRQ19
+							&IRQ20 &IRQ21 &IRQ22 &IRQ23>;
+				};
+
+				intc_sense3 {
+					reg = <0xe690000C 4>;
+					field-width = <4>;
+					reginfo = <&IRQ24 &IRQ25 &IRQ26 &IRQ27
+							&IRQ28 &IRQ29 &IRQ30 &IRQ31>;
+				};
+			};
+
+			intc_ack_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_ack0 {
+					reg = <0xe6900020 1>, <0x0 0>;
+					reginfo = <&IRQ0 &IRQ1 &IRQ2 &IRQ3 &IRQ4 &IRQ5 &IRQ6 &IRQ7>;
+				};
+
+				intc_ack1 {
+					reg = <0xe6900024 1>, <0x0 0>;
+					reginfo = <&IRQ8 &IRQ9 &IRQ10 &IRQ11
+							&IRQ12 &IRQ13 &IRQ14 &IRQ15>;
+				};
+
+				intc_ack2 {
+					reg = <0xe6900028 1>, <0x0 0>;
+					reginfo = <&IRQ16 &IRQ17 &IRQ18 &IRQ19
+							&IRQ20 &IRQ21 &IRQ22 &IRQ23>;
+				};
+
+				intc_ack3 {
+					reg = <0xe690002C 1>, <0x0 0>;
+					reginfo = <&IRQ24 &IRQ25 &IRQ26 &IRQ27
+							&IRQ28 &IRQ29 &IRQ30 &IRQ31>;
+				};
+			};
+		};
+
+		intc_pint0: interrupt-controller at 2 {
+			compatible = "renesas,sh_pint0";
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			reg = <0xe69000a0 0x20>;
+
+			PINTA0: intsrc1 { vector = <0x5980>; };
+			PINTA1: intsrc2 { vector = <0x59a0>; };
+			PINTA2: intsrc3 { vector = <0x59c0>; };
+			PINTA3: intsrc4 { vector = <0x59e0>; };
+			PINTA4: intsrc5 { vector = <0x5a00>; };
+			PINTA5: intsrc6 { vector = <0x5a20>; };
+			PINTA6: intsrc7 { vector = <0x5a40>; };
+			PINTA7: intsrc8 { vector = <0x5a60>; };
+			PINTB0: intsrc9 { vector = <0x5a80>; };
+			PINTB1: intsrc10 { vector = <0x5aa0>; };
+			PINTB2: intsrc11 { vector = <0x5ac0>; };
+			PINTB3: intsrc12 { vector = <0x5ae0>; };
+			PINTB4: intsrc13 { vector = <0x5b00>; };
+			PINTB5: intsrc14 { vector = <0x5b20>; };
+			PINTB6: intsrc15 { vector = <0x5b40>; };
+			PINTB7: intsrc16 { vector = <0x5b60>; };
+			PINTC0: intsrc17 { vector = <0x5b80>; };
+			PINTC1: intsrc18 { vector = <0x5ba0>; };
+			PINTC2: intsrc19 { vector = <0x5bc0>; };
+			PINTC3: intsrc20 { vector = <0x5be0>; };
+			PINTC4: intsrc21 { vector = <0x5c00>; };
+			PINTC5: intsrc22 { vector = <0x5c20>; };
+			PINTC6: intsrc23 { vector = <0x5c40>; };
+			PINTC7: intsrc24 { vector = <0x5c60>; };
+			PINTD0: intsrc25 { vector = <0x5c80>; };
+			PINTD1: intsrc26 { vector = <0x5ca0>; };
+			PINTD2: intsrc27 { vector = <0x5cc0>; };
+			PINTD3: intsrc28 { vector = <0x5ce0>; };
+			PINTD4: intsrc29 { vector = <0x5d00>; };
+			PINTD5: intsrc30 { vector = <0x5d20>; };
+			PINTD6: intsrc31 { vector = <0x5d40>; };
+			PINTD7: intsrc32 { vector = <0x5d60>; };
+
+			intc_vectors {
+				vector_table = <&PINTA0 &PINTA1 &PINTA2
+					&PINTA3 &PINTA4 &PINTA5 &PINTA6
+					&PINTA7 &PINTB0 &PINTB1 &PINTB2
+					&PINTB3 &PINTB4 &PINTB5 &PINTB6
+					&PINTB7 &PINTC0 &PINTC1 &PINTC2
+					&PINTC3 &PINTC4 &PINTC5 &PINTC6
+					&PINTC7 &PINTD0 &PINTD1 &PINTD2
+					&PINTD3 &PINTD4 &PINTD5 &PINTD6
+					&PINTD7>;
+			};
+
+			intc_mask_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_mask0 {
+					reg = <0xe69000a0 4>, <0x0 0>; /* FIXME */
+					reginfo = <&PINTA0 &PINTA1 &PINTA2
+						&PINTA3 &PINTA4 &PINTA5 &PINTA6
+						&PINTA7 &PINTB0 &PINTB1 &PINTB2
+						&PINTB3 &PINTB4 &PINTB5 &PINTB6
+						&PINTB7 &PINTC0 &PINTC1 &PINTC2
+						&PINTC3 &PINTC4 &PINTC5 &PINTC6
+						&PINTC7 &PINTD0 &PINTD1 &PINTD2
+						&PINTD3 &PINTD4 &PINTD5 &PINTD6
+						&PINTD7>;
+				};
+			};
+
+			intc_sense_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_sense0 {
+					reg = <0xe69000b0 2>, <0x0 0>;
+					field-width = <2>;
+					reginfo = <&PINTA0 &PINTA1 &PINTA2 &PINTA3
+							&PINTA4 &PINTA5 &PINTA6 &PINTA7>;
+				};
+
+				intc_sense1 {
+					reg = <0xe69000b4 2>, <0x0 0>;
+					field-width = <2>;
+					reginfo = <&PINTB0 &PINTB1 &PINTB2 &PINTB3
+							&PINTB4 &PINTB5 &PINTB6 &PINTB7>;
+				};
+
+				intc_sense2 {
+					reg = <0xe69000b8 2>, <0x0 0>;
+					field-width = <2>;
+					reginfo = <&PINTC0 &PINTC1 &PINTC2 &PINTC3
+							&PINTC4 &PINTC5 &PINTC6 &PINTC7>;
+				};
+
+				intc_sense3 {
+					reg = <0xe69000bc 2>, <0x0 0>;
+					field-width = <2>;
+					reginfo = <&PINTD0 &PINTD1 &PINTD2 &PINTD3
+							&PINTD4 &PINTD5 &PINTD6 &PINTD7>;
+				};
+			};
+		};
+
+		intc_pint1: interrupt-controller at 3 {
+			compatible = "renesas,sh_pint1";
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			ranges;
+
+			reg = <0xe69000a4 0x20>;
+
+			PINTE0: intsrc1 { vector = <0x5d80>; };
+			PINTE1: intsrc2 { vector = <0x5da0>; };
+			PINTE2: intsrc3 { vector = <0x5dc0>; };
+			PINTE3: intsrc4 { vector = <0x5de0>; };
+			PINTE4: intsrc5 { vector = <0x5e00>; };
+			PINTE5: intsrc6 { vector = <0x5e20>; };
+			PINTE6: intsrc7 { vector = <0x5e40>; };
+			PINTE7: intsrc8 { vector = <0x5e60>; };
+
+			intc_vectors {
+				vector_table = <&PINTE0 &PINTE1 &PINTE2
+					&PINTE3 &PINTE4 &PINTE5 &PINTE6
+					&PINTE7>;
+			};
+
+			intc_mask_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_mask0 {
+					reg = <0xe69000a4 4>, <0x0 0>; /* FIXME */
+					reginfo = <&PINTE0 &PINTE1 &PINTE2 &PINTE3
+						&PINTE4 &PINTE5 &PINTE6 &PINTE7>;
+				};
+			};
+
+			intc_sense_registers {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				intc_sense0 {
+					reg = <0xe69000c0 2>, <0x0 0>;
+					field-width = <2>;
+					reginfo = <&PINTE0 &PINTE1 &PINTE2 &PINTE3
+							&PINTE4 &PINTE5 &PINTE6 &PINTE7>;
+				};
+
+				intc_sense1 {
+					reg = <0xe69000c4 2>, <0x0 0>;
+					field-width = <2>;
+					reginfo = <0 0 0 0 0 0 0 0>;
+				};
+
+				intc_sense2 {
+					reg = <0xe69000c8 2>, <0x0 0>;
+					field-width = <2>;
+					reginfo = <0 0 0 0 0 0 0 0>;
+				};
+
+				intc_sense3 {
+					reg = <0xe69000cc 2>, <0x0 0>;
+					field-width = <2>;
+					reginfo = <0 0 0 0 0 0 0 0>;
+				};
+			};
+		};
+	};
+};
-- 
1.7.10.4
