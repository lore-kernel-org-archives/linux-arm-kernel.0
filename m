From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 29 Jan 2017 21:53:11 +0200
Subject: [PATCH 2/2] ARM: bcm2835: dts: fix uart0/uart1 pins
In-Reply-To: <9290fa9eed6b5ff1c5c96b9dac41eca286b7eef9.1485719591.git.baruch@tkos.co.il>
References: <9290fa9eed6b5ff1c5c96b9dac41eca286b7eef9.1485719591.git.baruch@tkos.co.il>
Message-ID: <e0f527a24b0048daba88ef36d5324245e003111c.1485719591.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the BCM2835 ARM Peripherals document uart1 doesn't map to pins
36-39, but uart0 does.

Also, split into separate Rx/Tx and CST/RTS groups to match other uart nodes.

Fixes: 21ff843931b ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/bcm283x.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 2ae842921250..9ee8346b8b19 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -306,6 +306,14 @@
 				brcm,pins = <32 33>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
 			};
+			uart0_gpio36: uart0_gpio36 {
+				brcm,pins = <36 37>;
+				brcm,function = <BCM2835_FSEL_ALT2>;
+			};
+			uart0_ctsrts_gpio38: uart0_ctsrts_gpio38 {
+				brcm,pins = <38 39>;
+				brcm,function = <BCM2835_FSEL_ALT2>;
+			};
 
 			uart1_gpio14: uart1_gpio14 {
 				brcm,pins = <14 15>;
@@ -323,10 +331,6 @@
 				brcm,pins = <30 31>;
 				brcm,function = <BCM2835_FSEL_ALT5>;
 			};
-			uart1_gpio36: uart1_gpio36 {
-				brcm,pins = <36 37 38 39>;
-				brcm,function = <BCM2835_FSEL_ALT2>;
-			};
 			uart1_gpio40: uart1_gpio40 {
 				brcm,pins = <40 41>;
 				brcm,function = <BCM2835_FSEL_ALT5>;
-- 
2.11.0
