From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 15 Aug 2016 15:03:44 +0800
Subject: [PATCH v3 4/5] arm64: dts: hip06: Append sas node
In-Reply-To: <1471244625-56331-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1467170878-24030-1-git-send-email-wangkefeng.wang@huawei.com>
 <1471244625-56331-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1471244625-56331-5-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sas and relevant nodes for Hip06 D03 board.

Cc: Xiang Chen <chenxiang66@hisilicon.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts |  12 +++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi    | 150 ++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
index 5562cf4..f54b283 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
@@ -41,6 +41,18 @@
 	status = "ok";
 };
 
+&sas0 {
+	status = "ok";
+};
+
+&sas1 {
+	status = "ok";
+};
+
+&sas2 {
+	status = "ok";
+};
+
 &usb_ohci {
 	status = "ok";
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index ddbff81..66b1bbf 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -277,6 +277,20 @@
 			#interrupt-cells = <2>;
 			num-pins = <2>;
 		};
+
+		mbigen_sas1: intc_sas1 {
+			msi-parent = <&its_dsa 0x40000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <128>;
+		};
+
+		mbigen_sas2: intc_sas2 {
+			msi-parent = <&its_dsa 0x40040>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <128>;
+		};
 	};
 
 	mbigen_dsa at c0080000 {
@@ -289,6 +303,13 @@
 			#interrupt-cells = <2>;
 			num-pins = <409>;
 		};
+
+		mbigen_sas0: intc-sas0 {
+			msi-parent = <&its_dsa 0x40900>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <128>;
+		};
 	};
 
 	soc {
@@ -325,6 +346,11 @@
 			reg = <0x0 0xc0000000 0x0 0x10000>;
 		};
 
+		pcie_subctl: pcie_subctl at a0000000 {
+			compatible = "hisilicon,pcie-sas-subctrl", "syscon";
+			reg = <0x0 0xa0000000 0x0 0x10000>;
+		};
+
 		serdes_ctrl: sds_ctrl at c2200000 {
 			compatible = "syscon";
 			reg = <0 0xc2200000 0x0 0x80000>;
@@ -517,6 +543,130 @@
 			status = "disabled";
 			dma-coherent;
 		};
+
+		sas0: sas at c3000000 {
+			compatible = "hisilicon,hip06-sas-v2";
+			reg = <0 0xc3000000 0 0x10000>;
+			sas-addr = [50 01 88 20 16 00 00 00];
+			hisilicon,sas-syscon = <&dsa_subctrl>;
+			ctrl-reset-reg = <0xa60>;
+			ctrl-reset-sts-reg = <0x5a30>;
+			ctrl-clock-ena-reg = <0x338>;
+			queue-count = <16>;
+			phy-count = <8>;
+			dma-coherent;
+			interrupt-parent = <&mbigen_sas0>;
+			interrupts = <64 4>,<65 4>,<66 4>,<67 4>,<68 4>,
+					<69 4>,<70 4>,<71 4>,<72 4>,<73 4>,
+					<75 4>,<76 4>,<77 4>,<78 4>,<79 4>,
+					<80 4>,<81 4>,<82 4>,<83 4>,<84 4>,
+					<85 4>,<86 4>,<87 4>,<88 4>,<89 4>,
+					<90 4>,<91 4>,<92 4>,<93 4>,<94 4>,
+					<95 4>,<96 4>,<97 4>,<98 4>,<99 4>,
+					<100 4>,<101 4>,<102 4>,<103 4>,<104 4>,
+					<105 4>,<106 4>,<107 4>,<108 4>,<109 4>,
+					<110 4>,<111 4>,<112 4>,<113 4>,<114 4>,
+					<115 4>,<116 4>,<117 4>,<118 4>,<119 4>,
+					<120 4>,<121 4>,<122 4>,<123 4>,<124 4>,
+					<125 4>,<126 4>,<127 4>,<128 4>,<129 4>,
+					<130 4>,<131 4>,<132 4>,<133 4>,<134 4>,
+					<135 4>,<136 4>,<137 4>,<138 4>,<139 4>,
+					<140 4>,<141 4>,<142 4>,<143 4>,<144 4>,
+					<145 4>,<146 4>,<147 4>,<148 4>,<149 4>,
+					<150 4>,<151 4>,<152 4>,<153 4>,<154 4>,
+					<155 4>,<156 4>,<157 4>,<158 4>,<159 4>,
+					<160 4>,<601 1>,<602 1>,<603 1>,<604 1>,
+					<605 1>,<606 1>,<607 1>,<608 1>,<609 1>,
+					<610 1>,<611 1>,<612 1>,<613 1>,<614 1>,
+					<615 1>,<616 1>,<617 1>,<618 1>,<619 1>,
+					<620 1>,<621 1>,<622 1>,<623 1>,<624 1>,
+					<625 1>,<626 1>,<627 1>,<628 1>,<629 1>,
+					<630 1>,<631 1>,<632 1>;
+			status = "disabled";
+		};
+
+		sas1: sas at a2000000 {
+			compatible = "hisilicon,hip06-sas-v2";
+			reg = <0 0xa2000000 0 0x10000>;
+			sas-addr = [50 01 88 20 16 00 00 00];
+			hisilicon,sas-syscon = <&pcie_subctl>;
+			am-max-trans;
+			ctrl-reset-reg = <0xa18>;
+			ctrl-reset-sts-reg = <0x5a0c>;
+			ctrl-clock-ena-reg = <0x318>;
+			queue-count = <16>;
+			phy-count = <8>;
+			dma-coherent;
+			interrupt-parent = <&mbigen_sas1>;
+			interrupts = <64 4>,<65 4>,<66 4>,<67 4>,<68 4>,
+					<69 4>,<70 4>,<71 4>,<72 4>,<73 4>,
+					<74 4>,<75 4>,<76 4>,<77 4>,<78 4>,
+					<79 4>,<80 4>,<81 4>,<82 4>,<83 4>,
+					<84 4>,<85 4>,<86 4>,<87 4>,<88 4>,
+					<89 4>,<90 4>,<91 4>,<92 4>,<93 4>,
+					<94 4>,<95 4>,<96 4>,<97 4>,<98 4>,
+					<99 4>,<100 4>,<101 4>,<102 4>,<103 4>,
+					<104 4>,<105 4>,<106 4>,<107 4>,<108 4>,
+					<109 4>,<110 4>,<111 4>,<112 4>,<113 4>,
+					<114 4>,<115 4>,<116 4>,<117 4>,<118 4>,
+					<119 4>,<120 4>,<121 4>,<122 4>,<123 4>,
+					<124 4>,<125 4>,<126 4>,<127 4>,<128 4>,
+					<129 4>,<130 4>,<131 4>,<132 4>,<133 4>,
+					<134 4>,<135 4>,<136 4>,<137 4>,<138 4>,
+					<139 4>,<140 4>,<141 4>,<142 4>,<143 4>,
+					<144 4>,<145 4>,<146 4>,<147 4>,<148 4>,
+					<149 4>,<150 4>,<151 4>,<152 4>,<153 4>,
+					<154 4>,<155 4>,<156 4>,<157 4>,<158 4>,
+					<159 4>,<576 1>,<577 1>,<578 1>,<579 1>,
+					<580 1>,<581 1>,<582 1>,<583 1>,<584 1>,
+					<585 1>,<586 1>,<587 1>,<588 1>,<589 1>,
+					<590 1>,<591 1>,<592 1>,<593 1>,<594 1>,
+					<595 1>,<596 1>,<597 1>,<598 1>,<599 1>,
+					<600 1>,<601 1>,<602 1>,<603 1>,<604 1>,
+					<605 1>,<606 1>,<607 1>;
+			status = "disabled";
+		};
+
+		sas2: sas at a3000000 {
+			compatible = "hisilicon,hip06-sas-v2";
+			reg = <0 0xa3000000 0 0x10000>;
+			sas-addr = [50 01 88 20 16 00 00 00];
+			hisilicon,sas-syscon = <&pcie_subctl>;
+			ctrl-reset-reg = <0xae0>;
+			ctrl-reset-sts-reg = <0x5a70>;
+			ctrl-clock-ena-reg = <0x3a8>;
+			queue-count = <16>;
+			phy-count = <9>;
+			dma-coherent;
+			interrupt-parent = <&mbigen_sas2>;
+			interrupts = <192 4>,<193 4>,<194 4>,<195 4>,<196 4>,
+					<197 4>,<198 4>,<199 4>,<200 4>,<201 4>,
+					<202 4>,<203 4>,<204 4>,<205 4>,<206 4>,
+					<207 4>,<208 4>,<209 4>,<210 4>,<211 4>,
+					<212 4>,<213 4>,<214 4>,<215 4>,<216 4>,
+					<217 4>,<218 4>,<219 4>,<220 4>,<221 4>,
+					<222 4>,<223 4>,<224 4>,<225 4>,<226 4>,
+					<227 4>,<228 4>,<229 4>,<230 4>,<231 4>,
+					<232 4>,<233 4>,<234 4>,<235 4>,<236 4>,
+					<237 4>,<238 4>,<239 4>,<240 4>,<241 4>,
+					<242 4>,<243 4>,<244 4>,<245 4>,<246 4>,
+					<247 4>,<248 4>,<249 4>,<250 4>,<251 4>,
+					<252 4>,<253 4>,<254 4>,<255 4>,<256 4>,
+					<257 4>,<258 4>,<259 4>,<260 4>,<261 4>,
+					<262 4>,<263 4>,<264 4>,<265 4>,<266 4>,
+					<267 4>,<268 4>,<269 4>,<270 4>,<271 4>,
+					<272 4>,<273 4>,<274 4>,<275 4>,<276 4>,
+					<277 4>,<278 4>,<279 4>,<280 4>,<281 4>,
+					<282 4>,<283 4>,<284 4>,<285 4>,<286 4>,
+					<287 4>,<608 1>,<609 1>,<610 1>,<611 1>,
+					<612 1>,<613 1>,<614 1>,<615 1>,<616 1>,
+					<617 1>,<618 1>,<619 1>,<620 1>,<621 1>,
+					<622 1>,<623 1>,<624 1>,<625 1>,<626 1>,
+					<627 1>,<628 1>,<629 1>,<630 1>,<631 1>,
+					<632 1>,<633 1>,<634 1>,<635 1>,<636 1>,
+					<637 1>,<638 1>,<639 1>;
+			status = "disabled";
+		};
 	};
 
 };
-- 
1.7.12.4
