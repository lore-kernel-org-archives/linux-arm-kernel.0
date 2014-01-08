From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed,  8 Jan 2014 18:07:20 -0500
Subject: [RFC 4/5] imx:vf610: Add device tree support for the fsl_nfc driver
 and NAND interface.
In-Reply-To: <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
Message-ID: <1389222441-4322-5-git-send-email-bpringlemeir@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 41 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi    |  9 +++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index c8047ca..a652516 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -74,6 +74,47 @@
 	status = "okay";
 };
 
+&iomuxc {
+        vf610-twr {
+		pinctrl_nfc_1: nfcgrp_1 {
+			fsl,pins = <
+			VF610_PAD_PTD31__NF_IO15	0x28df
+			VF610_PAD_PTD30__NF_IO14	0x28df
+			VF610_PAD_PTD29__NF_IO13	0x28df
+			VF610_PAD_PTD28__NF_IO12	0x28df
+			VF610_PAD_PTD27__NF_IO11	0x28df
+			VF610_PAD_PTD26__NF_IO10	0x28df
+			VF610_PAD_PTD25__NF_IO9		0x28df
+			VF610_PAD_PTD24__NF_IO8		0x28df
+			VF610_PAD_PTD23__NF_IO7		0x28df
+			VF610_PAD_PTD22__NF_IO6		0x28df
+			VF610_PAD_PTD21__NF_IO5		0x28df
+			VF610_PAD_PTD20__NF_IO4		0x28df
+			VF610_PAD_PTD19__NF_IO3		0x28df
+			VF610_PAD_PTD18__NF_IO2		0x28df
+			VF610_PAD_PTD17__NF_IO1		0x28df
+			VF610_PAD_PTD16__NF_IO0		0x28df
+			VF610_PAD_PTB24__NF_WE_B	0x28c2
+			VF610_PAD_PTB25__NF_CE0_B	0x28c2
+			VF610_PAD_PTB27__NF_RE_B	0x28c2
+			VF610_PAD_PTC26__NF_RB_B	0x283d
+			VF610_PAD_PTC27__NF_ALE		0x28c2
+			VF610_PAD_PTC28__NF_CLE		0x28c2
+			>;
+		};
+	};
+};
+
+&nfc {
+	nand-bus-width = <16>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	clock-frequency = <33000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nfc_1>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index d31ce1b..04bc727 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -471,6 +471,15 @@
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
+
+			nfc: nand at 400e0000 {
+				compatible = "fsl,vf610-nfc";
+				reg = <0x400e0000 0x4000>;
+				interrupts = <0 83 0x04>;
+				clocks = <&clks VF610_CLK_NFC>;
+				clock-names = "nfc";
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
1.8.0.2
