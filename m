From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  2 Jun 2015 11:37:49 +0200
Subject: [PATCH v3 3/3] ARM: berlin: add SPI nodes for BG2Q
In-Reply-To: <1433237869-3762-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1433237869-3762-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1433237869-3762-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q SoC has two SPI controllers. Add the corresponding nodes.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 187d056f7ad2..ddf7e47fc487 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -286,6 +286,19 @@
 				status = "disabled";
 			};
 
+			spi1: spi at 1c00 {
+				compatible = "snps,dw-apb-ssi";
+				reg = <0x1c00 0x100>;
+				interrupts = <7>;
+				clocks = <&chip_clk CLKID_CFG>;
+				pinctrl-0 = <&spi1_pmux>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				num-cs = <4>;
+				status = "disabled";
+			};
+
 			timer0: timer at 2c00 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c00 0x14>;
@@ -383,6 +396,11 @@
 					groups = "G7";
 					function = "twsi1";
 				};
+
+				spi1_pmux: spi1-pmux {
+					groups = "G8";
+					function = "spi1";
+				};
 			};
 
 			chip_rst: reset {
@@ -473,6 +491,19 @@
 				};
 			};
 
+			spi2: spi at 6000 {
+				compatible = "snps,dw-apb-ssi";
+				reg = <0x6000 0x100>;
+				interrupts = <5>;
+				clocks = <&refclk>;
+				pinctrl-0 = <&spi2_pmux>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				num-cs = <4>;
+				status = "disabled";
+			};
+
 			i2c2: i2c at 7000 {
 				compatible = "snps,designware-i2c";
 				#address-cells = <1>;
@@ -564,6 +595,11 @@
 						groups = "GSM14";
 						function = "twsi3";
 					};
+
+					spi2_pmux: spi2-pmux {
+						groups = "GSM3";
+						function = "spi2";
+					};
 				};
 			};
 
-- 
2.4.2
