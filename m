From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:54 -0800
Subject: [PATCH 13/18] ARM: dts: vf610: add WKPU connection to GPIO
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-14-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GPIO have extended wake-up capabilities through the WKPU
module. Encode the connection between the GPIO's and the WKPU
interrupt sources in the device tree.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vfxxx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 335f4e5..869b230 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -383,6 +383,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				gpio-ranges = <&iomuxc 0 0 32>;
+				fsl,gpio-wakeup = <&wakeup 22 0 8>; /* PTB0...PTB7 */
 			};
 
 			gpio1: gpio at 4004a000 {
@@ -394,6 +395,10 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				gpio-ranges = <&iomuxc 0 32 32>;
+				fsl,gpio-wakeup = <&wakeup 1 8 2>, /* PTB11, PTB12 (NMI)*/
+						<&wakeup 4 10 1>, /* PTB14 */
+						<&wakeup 6 11 1>, /* PTB16 */
+						<&wakeup 9 12 2>; /* PTB19, PTB20 */
 			};
 
 			gpio2: gpio at 4004b000 {
@@ -416,6 +421,9 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				gpio-ranges = <&iomuxc 0 96 32>;
+				fsl,gpio-wakeup = <&wakeup 1 14 1>, /* PTB27 */
+						<&wakeup 7 15 1>, /* PTC30 */
+						<&wakeup 29 16 1>; /* PTE20 */
 			};
 
 			gpio4: gpio at 4004d000 {
-- 
2.7.2
