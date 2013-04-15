From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 15 Apr 2013 21:08:21 +0200
Subject: [PATCH v2] ARM: ux500: DT: Rename root node "soc-u9500" into "soc"
Message-ID: <1366052901-32490-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@stericsson.com>

This root node is used in the whole family of chips, the a9500
is just one particular instance. Nodes should be named after
the type of object rather than identity.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
Reviewed-by: Philippe Langlais <philippe.langlais@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rename from "sox-ux500" to just "soc" at Stephen's suggestion.
---
 arch/arm/boot/dts/ccu9540.dts     | 2 +-
 arch/arm/boot/dts/dbx5x0.dtsi     | 2 +-
 arch/arm/boot/dts/href.dtsi       | 2 +-
 arch/arm/boot/dts/hrefprev60.dts  | 2 +-
 arch/arm/boot/dts/hrefv60plus.dts | 2 +-
 arch/arm/boot/dts/snowball.dts    | 2 +-
 arch/arm/boot/dts/stuib.dtsi      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ccu9540.dts b/arch/arm/boot/dts/ccu9540.dts
index 0430546..c72d7aa 100644
--- a/arch/arm/boot/dts/ccu9540.dts
+++ b/arch/arm/boot/dts/ccu9540.dts
@@ -20,7 +20,7 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
-	soc-u9500 {
+	soc {
 		uart at 80120000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index d765c38..c028fe4 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -12,7 +12,7 @@
 /include/ "skeleton.dtsi"
 
 / {
-	soc-u9500 {
+	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "stericsson,db8500";
diff --git a/arch/arm/boot/dts/href.dtsi b/arch/arm/boot/dts/href.dtsi
index f2c0f66..85bab39 100644
--- a/arch/arm/boot/dts/href.dtsi
+++ b/arch/arm/boot/dts/href.dtsi
@@ -27,7 +27,7 @@
 		};
 	};
 
-	soc-u9500 {
+	soc {
 		uart at 80120000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/hrefprev60.dts b/arch/arm/boot/dts/hrefprev60.dts
index c2d2748..8a9357b 100644
--- a/arch/arm/boot/dts/hrefprev60.dts
+++ b/arch/arm/boot/dts/hrefprev60.dts
@@ -24,7 +24,7 @@
 		};
 	};
 
-	soc-u9500 {
+	soc {
 		prcmu at 80157000 {
 			ab8500 at 5 {
 				ab8500-gpio {
diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 55f4191..665f3a7 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -24,7 +24,7 @@
 		};
 	};
 
-	soc-u9500 {
+	soc {
 		i2c at 80110000 {
 			bu21013_tp at 0x5c {
 				reset-gpio = <&gpio4 15 0x4>;
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 5fcd7a8..5d1c55c 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -82,7 +82,7 @@
 		};
 	};
 
-	soc-u9500 {
+	soc {
 
 		sound {
 			compatible = "stericsson,snd-soc-mop500";
diff --git a/arch/arm/boot/dts/stuib.dtsi b/arch/arm/boot/dts/stuib.dtsi
index 615392a..7fa10a7 100644
--- a/arch/arm/boot/dts/stuib.dtsi
+++ b/arch/arm/boot/dts/stuib.dtsi
@@ -10,7 +10,7 @@
  */
 
 / {
-	soc-u9500 {
+	soc {
 		i2c at 80004000 {
 			stmpe1601: stmpe1601 at 40 {
 				compatible = "st,stmpe1601";
-- 
1.7.11.3
