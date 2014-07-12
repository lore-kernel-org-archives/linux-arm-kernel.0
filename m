From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Jul 2014 21:31:15 +0200
Subject: [PATCH 7/7] ARM: dts: rockchip: add saradc nodes
In-Reply-To: <16344051.ZPa9bzz4Fj@diego>
References: <16344051.ZPa9bzz4Fj@diego>
Message-ID: <4866856.TxetFWNmpJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds devicetree nodes for the SAR A/D converter including the board
specific regulator references for the two boards currently supported.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts |  5 +++++
 arch/arm/boot/dts/rk3188-radxarock.dts |  5 +++++
 arch/arm/boot/dts/rk3xxx.dtsi          | 11 +++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 4174ff8..d90a058 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -83,6 +83,11 @@
 			};
 		};
 
+		saradc: saradc at 2006c000 {
+			status = "okay";
+			vref-supply = <&vpll_reg>;
+		};
+
 		gpio-keys {
 			compatible = "gpio-keys";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index f277237..19d45b4 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -52,6 +52,11 @@
 			vin-supply = <&vcc_io>;
 		};
 
+		saradc: saradc at 2006c000 {
+			status = "okay";
+			vref-supply = <&vcc18>;
+		};
+
 		gpio-keys {
 			compatible = "gpio-keys";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 1623e21..69d866a 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -261,5 +261,16 @@
 			clocks = <&cru PCLK_PWM23>;
 			status = "disabled";
 		};
+
+		saradc at 2006c000 {
+			compatible = "rockchip,saradc";
+			reg = <0x2006c000 0x100>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
+			clock-names = "saradc", "apb_pclk";
+			#io-channel-cells = <1>;
+			clock-frequency = <1000000>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.0
