From: brezillonboris@gmail.com (Boris BREZILLON)
Date: Tue, 18 Mar 2014 21:18:41 +0100
Subject: [PATCH 08/11] ARM: at91/dt: move at91sam9261 SoC to the new main
 clock model
In-Reply-To: <1395173924-3648-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1395173924-3648-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1395173924-3648-9-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index e21dda0..e00fabc 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -45,6 +45,14 @@
 		reg = <0x20000000 0x08000000>;
 	};
 
+	clocks {
+		main_xtal: main_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -534,7 +542,7 @@
 					compatible = "atmel,at91rm9200-clk-main";
 					#clock-cells = <0>;
 					interrupts-extended = <&pmc AT91_PMC_MOSCS>;
-					clocks = <&clk32k>;
+					clocks = <&main_xtal>;
 				};
 
 				plla: pllack {
-- 
1.7.9.5
