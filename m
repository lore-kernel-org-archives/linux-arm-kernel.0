From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 27 May 2013 13:19:29 +0200
Subject: [PATCH] ARM: ux500: bump MMC/SD max frequency for DT boots
Message-ID: <1369653569-21855-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

In patch:
"ARM: ux500: Enable 100MHz for SD/SDIO/MMC devices"
the max frequency for the MMC/SD/SDIO adapters was
increased from 50 to 100MHz. Do the same for the
device tree boot path.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Gabriel Fernandez <gabriel.fernandez.st@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ccu9540.dts     | 2 +-
 arch/arm/boot/dts/href.dtsi       | 8 ++++----
 arch/arm/boot/dts/hrefv60plus.dts | 8 ++++----
 arch/arm/boot/dts/snowball.dts    | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ccu9540.dts b/arch/arm/boot/dts/ccu9540.dts
index c72d7aa..b657d71 100644
--- a/arch/arm/boot/dts/ccu9540.dts
+++ b/arch/arm/boot/dts/ccu9540.dts
@@ -52,7 +52,7 @@
 		// WLAN SDIO channel
 		sdi1_per2 at 80118000 {
 			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <50000000>;
+			max-frequency = <100000000>;
 			bus-width = <4>;
 
 			status = "okay";
diff --git a/arch/arm/boot/dts/href.dtsi b/arch/arm/boot/dts/href.dtsi
index e315429..567a18b 100644
--- a/arch/arm/boot/dts/href.dtsi
+++ b/arch/arm/boot/dts/href.dtsi
@@ -108,7 +108,7 @@
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
 			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <50000000>;
+			max-frequency = <100000000>;
 			bus-width = <4>;
 			mmc-cap-sd-highspeed;
 			mmc-cap-mmc-highspeed;
@@ -123,7 +123,7 @@
 		// WLAN SDIO channel
 		sdi1_per2 at 80118000 {
 			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <50000000>;
+			max-frequency = <100000000>;
 			bus-width = <4>;
 
 			status = "okay";
@@ -132,7 +132,7 @@
 		// PoP:ed eMMC
 		sdi2_per3 at 80005000 {
 			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <50000000>;
+			max-frequency = <100000000>;
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
 
@@ -142,7 +142,7 @@
 		// On-board eMMC
 		sdi4_per2 at 80114000 {
 			arm,primecell-periphid = <0x10480180>;
-		        max-frequency = <50000000>;
+		        max-frequency = <100000000>;
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 5dfc73a..26f33a6f 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -34,7 +34,7 @@
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
 			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <50000000>;
+			max-frequency = <100000000>;
 			bus-width = <4>;
 			mmc-cap-sd-highspeed;
 			mmc-cap-mmc-highspeed;
@@ -48,7 +48,7 @@
 		// WLAN SDIO channel
 		sdi1_per2 at 80118000 {
 			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <50000000>;
+			max-frequency = <100000000>;
 			bus-width = <4>;
 
 			status = "okay";
@@ -57,7 +57,7 @@
 		// PoP:ed eMMC
 		sdi2_per3 at 80005000 {
 			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <50000000>;
+			max-frequency = <100000000>;
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
 
@@ -67,7 +67,7 @@
 		// On-board eMMC
 		sdi4_per2 at 80114000 {
 			arm,primecell-periphid = <0x10480180>;
-		        max-frequency = <50000000>;
+		        max-frequency = <100000000>;
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index e8219cc7..829a65f 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -129,7 +129,7 @@
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
 			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <50000000>;
+			max-frequency = <100000000>;
 			bus-width = <4>;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
@@ -144,7 +144,7 @@
 		// On-board eMMC
 		sdi4_per2 at 80114000 {
 			arm,primecell-periphid = <0x10480180>;
-		        max-frequency = <50000000>;
+		        max-frequency = <100000000>;
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
-- 
1.7.11.3
