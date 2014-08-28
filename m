From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 28 Aug 2014 13:34:15 +0800
Subject: [PATCH v2 1/6] ARM: dts: hix5hd2: add gmac node
In-Reply-To: <1409204060-9223-1-git-send-email-zhangfei.gao@linaro.org>
References: <1409204060-9223-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1409204060-9223-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts |   28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/hisi-x5hd2.dtsi    |   16 ++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
index 05b44c2..0da3f3b 100644
--- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
+++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
@@ -51,3 +51,31 @@
 &uart0 {
 	status = "okay";
 };
+
+&gmac0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	phy-handle = <&phy2>;
+	phy-mode = "mii";
+	/* Placeholder, overwritten by bootloader */
+	mac-address = [00 00 00 00 00 00];
+	status = "okay";
+
+	phy2: ethernet-phy at 2 {
+		reg = <2>;
+	};
+};
+
+&gmac1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii";
+	/* Placeholder, overwritten by bootloader */
+	mac-address = [00 00 00 00 00 00];
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index f85ba29..012525c 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -166,5 +166,21 @@
 				#clock-cells = <1>;
 			};
 		};
+
+		gmac0: ethernet at 1840000 {
+			compatible = "hisilicon,hix5hd2-gmac";
+			reg = <0x1840000 0x1000>,<0x184300c 0x4>;
+			interrupts = <0 71 4>;
+			clocks = <&clock HIX5HD2_MAC0_CLK>;
+			status = "disabled";
+		};
+
+		gmac1: ethernet at 1841000 {
+			compatible = "hisilicon,hix5hd2-gmac";
+			reg = <0x1841000 0x1000>,<0x1843010 0x4>;
+			interrupts = <0 72 4>;
+			clocks = <&clock HIX5HD2_MAC1_CLK>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
