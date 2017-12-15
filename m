From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:54:33 +1030
Subject: [PATCH v2 09/19] ARM: dts: aspeed: Add PWM and tachometer node
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-10-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 9 +++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index fa52a01f50b5..f6fee40c04c0 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -189,6 +189,15 @@
 				clocks = <&syscon ASPEED_CLK_APB>;
 			};
 
+			pwm_tacho: pwm-tacho-controller at 1e786000 {
+				compatible = "aspeed,ast2400-pwm-tacho";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1e786000 0x1000>;
+				clocks = <&syscon ASPEED_CLK_APB>;
+				status = "disabled";
+			};
+
 			vuart: serial at 1e787000 {
 				compatible = "aspeed,ast2400-vuart";
 				reg = <0x1e787000 0x40>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 5e6db2aa5c23..96a9d2fe3f0d 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -239,6 +239,15 @@
 				status = "disabled";
 			};
 
+			pwm_tacho: pwm-tacho-controller at 1e786000 {
+				compatible = "aspeed,ast2500-pwm-tacho";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1e786000 0x1000>;
+				clocks = <&syscon ASPEED_CLK_APB>;
+				status = "disabled";
+			};
+
 			vuart: serial at 1e787000 {
 				compatible = "aspeed,ast2500-vuart";
 				reg = <0x1e787000 0x40>;
-- 
2.14.1
