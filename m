From: amonakov@ispras.ru (Alexander Monakov)
Date: Sun, 11 Mar 2018 19:00:06 +0300
Subject: [PATCH 6/8] ARM: dts: berlin2cd: add remaining nodes to apb subtrees
In-Reply-To: <20180311160008.22928-1-amonakov@ispras.ru>
References: <20180311160008.22928-1-amonakov@ispras.ru>
Message-ID: <20180311160008.22928-7-amonakov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds most of the remaining Designware IP cores under APB trees in
the interest of documenting assignment of interrupts and memory ranges.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 7da6da3f0222..c1da34c3c32c 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -274,6 +274,60 @@
 				};
 			};
 
+			i2c0: i2c at 1400 {
+				compatible = "snps,designware-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1400 0x100>;
+				interrupts = <16>;
+				clocks = <&chip_clk CLKID_CFG>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at 1800 {
+				compatible = "snps,designware-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1800 0x100>;
+				interrupts = <17>;
+				clocks = <&chip_clk CLKID_CFG>;
+				status = "disabled";
+			};
+
+			spi0: spi at 1c00 {
+				compatible = "snps,dw-apb-ssi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1c00 0x100>;
+				interrupts = <4>;
+				clocks = <&chip_clk CLKID_CFG>;
+				status = "disabled";
+			};
+
+			wdt4: watchdog at 2000 {
+				compatible = "snps,dw-wdt";
+				reg = <0x2000 0x100>;
+				clocks = <&chip_clk CLKID_CFG>;
+				interrupts = <5>;
+				status = "disabled";
+			};
+
+			wdt5: watchdog at 2400 {
+				compatible = "snps,dw-wdt";
+				reg = <0x2400 0x100>;
+				clocks = <&chip_clk CLKID_CFG>;
+				interrupts = <6>;
+				status = "disabled";
+			};
+
+			wdt6: watchdog at 2800 {
+				compatible = "snps,dw-wdt";
+				reg = <0x2800 0x100>;
+				clocks = <&chip_clk CLKID_CFG>;
+				interrupts = <7>;
+				status = "disabled";
+			};
+
 			timer0: timer at 2c00 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c00 0x14>;
@@ -455,6 +509,36 @@
 				};
 			};
 
+			spi1: spi at 6000 {
+				compatible = "snps,dw-apb-ssi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x6000 0x100>;
+				clocks = <&refclk>;
+				interrupts = <5>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at 7000 {
+				compatible = "snps,designware-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x7000 0x100>;
+				interrupts = <6>;
+				clocks = <&refclk>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 8000 {
+				compatible = "snps,designware-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x8000 0x100>;
+				interrupts = <7>;
+				clocks = <&refclk>;
+				status = "disabled";
+			};
+
 			sm_gpio0: gpio at c000 {
 				compatible = "snps,dw-apb-gpio";
 				reg = <0xc000 0x400>;
@@ -492,6 +576,16 @@
 				status = "disabled";
 			};
 
+			uart2: serial at b000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0xb000 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <1>;
+				interrupts = <10>;
+				clocks = <&refclk>;
+				status = "disabled";
+			};
+
 			sysctrl: system-controller at d000 {
 				compatible = "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
-- 
2.11.0
