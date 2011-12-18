From: jamie@jamieiles.com (Jamie Iles)
Date: Sun, 18 Dec 2011 10:13:49 +0000
Subject: [PATCH 2/2] ARM: picoxcell: use new Synopsys Designware GPIO binding
In-Reply-To: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
References: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1324203229-15571-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi |   19 ++++++++-----------
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi |   28 +++++++++++-----------------
 2 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
index f0a8c20..887b331c 100644
--- a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
+++ b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
@@ -169,28 +169,25 @@
 				reg = <0x20000 0x1000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg-io-width = <4>;
 
 				banka: gpio-controller at 0 {
 					compatible = "snps,dw-apb-gpio-bank";
 					gpio-controller;
 					#gpio-cells = <2>;
-					gpio-generic,nr-gpio = <8>;
-
-					regoffset-dat = <0x50>;
-					regoffset-set = <0x00>;
-					regoffset-dirout = <0x04>;
+					nr-gpio = <8>;
+					snps,gpio-bank = <0>
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupt-parent = <&vic1>;
+					interrupts = <0 1 2 3 4 5 6 7>;
 				};
 
 				bankb: gpio-controller at 1 {
 					compatible = "snps,dw-apb-gpio-bank";
 					gpio-controller;
 					#gpio-cells = <2>;
-					gpio-generic,nr-gpio = <8>;
-
-					regoffset-dat = <0x54>;
-					regoffset-set = <0x0c>;
-					regoffset-dirout = <0x10>;
+					nr-gpio = <8>;
+					snps,gpio-bank = <1>
 				};
 			};
 
diff --git a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
index daa962d..dea5981 100644
--- a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
+++ b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
@@ -252,39 +252,33 @@
 				reg = <0x20000 0x1000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg-io-width = <4>;
 
 				banka: gpio-controller at 0 {
 					compatible = "snps,dw-apb-gpio-bank";
 					gpio-controller;
+					snps,gpio-bank = <0>;
 					#gpio-cells = <2>;
-					gpio-generic,nr-gpio = <8>;
-
-					regoffset-dat = <0x50>;
-					regoffset-set = <0x00>;
-					regoffset-dirout = <0x04>;
+					nr-gpio = <8>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupt-parent = <&vic1>;
+					interrupts = <0 1 2 3 4 5 6 7>;
 				};
 
 				bankb: gpio-controller at 1 {
 					compatible = "snps,dw-apb-gpio-bank";
 					gpio-controller;
+					snps,gpio-bank = <1>;
 					#gpio-cells = <2>;
-					gpio-generic,nr-gpio = <16>;
-
-					regoffset-dat = <0x54>;
-					regoffset-set = <0x0c>;
-					regoffset-dirout = <0x10>;
+					nr-gpio = <16>;
 				};
 
-				bankd: gpio-controller at 2 {
+				bankd: gpio-controller at 3 {
 					compatible = "snps,dw-apb-gpio-bank";
 					gpio-controller;
+					snps,gpio-bank = <3>;
 					#gpio-cells = <2>;
-					gpio-generic,nr-gpio = <30>;
-
-					regoffset-dat = <0x5c>;
-					regoffset-set = <0x24>;
-					regoffset-dirout = <0x28>;
+					nr-gpio = <30>;
 				};
 			};
 
-- 
1.7.5.4
