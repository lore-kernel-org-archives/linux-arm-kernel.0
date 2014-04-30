From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 14:56:38 +0200
Subject: [PATCH 11/15] ARM: dts: kirkwood: set default pinctrl for NAND
In-Reply-To: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1398862602-29595-12-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one valid pinctrl setting for NAND on Kirkwood. Now that we
have the setting in the common SoC pinctrl, move it to the NAND controller
node directly and remove it from the individual boards.

While at it, also fix up status = "okay" to "ok" on one board's NAND node.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/kirkwood-db.dtsi                | 2 --
 arch/arm/boot/dts/kirkwood-dnskw.dtsi             | 2 --
 arch/arm/boot/dts/kirkwood-ib62x0.dts             | 2 --
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts        | 4 +---
 arch/arm/boot/dts/kirkwood-laplug.dts             | 1 -
 arch/arm/boot/dts/kirkwood-mplcec4.dts            | 2 --
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts      | 2 --
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts      | 2 --
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi | 2 --
 arch/arm/boot/dts/kirkwood-topkick.dts            | 2 --
 arch/arm/boot/dts/kirkwood.dtsi                   | 2 ++
 11 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-db.dtsi b/arch/arm/boot/dts/kirkwood-db.dtsi
index 2790f46d87e0..812df691ae3d 100644
--- a/arch/arm/boot/dts/kirkwood-db.dtsi
+++ b/arch/arm/boot/dts/kirkwood-db.dtsi
@@ -57,8 +57,6 @@
 };
 
 &nand {
-	pinctrl-0 = <&pmx_nand>;
-	pinctrl-names = "default";
 	chip-delay = <25>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index bcc6e0f48571..113dcf056dcf 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -183,8 +183,6 @@
 };
 
 &nand {
-	pinctrl-0 = <&pmx_nand>;
-	pinctrl-names = "default";
 	status = "okay";
 	chip-delay = <35>;
 
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index 6804638eb87e..bfa5edde179c 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -105,8 +105,6 @@
 
 &nand {
 	status = "okay";
-	pinctrl-0 = <&pmx_nand>;
-	pinctrl-names = "default";
 
 	partition at 0 {
 		label = "u-boot";
diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
index db14bd03b86b..61139bf30985 100644
--- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
+++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
@@ -46,9 +46,7 @@
 };
 
 &nand {
-	pinctrl-0 = <&pmx_nand>;
-	pinctrl-names = "default";
-	status = "ok";
+	status = "okay";
 	chip-delay = <25>;
 };
 
diff --git a/arch/arm/boot/dts/kirkwood-laplug.dts b/arch/arm/boot/dts/kirkwood-laplug.dts
index 4c91fbb084c5..642755acf2fe 100644
--- a/arch/arm/boot/dts/kirkwood-laplug.dts
+++ b/arch/arm/boot/dts/kirkwood-laplug.dts
@@ -138,7 +138,6 @@
 &nand {
 	/* Total size : 512MB */
 	status = "okay";
-	pinctrl-0 = <&pmx_nand>;
 
 	partition at 0 {
 		label = "u-boot";
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 79796c8b9c4f..f3a991837515 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -162,8 +162,6 @@
 };
 
 &nand {
-	pinctrl-0 = <&pmx_nand>;
-	pinctrl-names = "default";
 	status = "okay";
 
 	partition at 0 {
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 1e056b3b1817..00c2e5a9d863 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -130,8 +130,6 @@
 &nand {
 	chip-delay = <25>;
 	status = "okay";
-	pinctrl-0 = <&pmx_nand>;
-	pinctrl-names = "default";
 
 	partition at 0 {
 		label = "uboot";
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
index 07f6bf6aba91..bc07aa5e6698 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -148,8 +148,6 @@
 &nand {
 	chip-delay = <25>;
 	status = "okay";
-	pinctrl-0 = <&pmx_nand>;
-	pinctrl-names = "default";
 
 	partition at 0 {
 		label = "uboot";
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
index e2c43aecc7b2..7196c7f3e109 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
@@ -71,8 +71,6 @@
 };
 
 &nand {
-	pinctrl-0 = <&pmx_nand>;
-	pinctrl-names = "default";
 	status = "okay";
 
 	partition at 0 {
diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index 14b12189d464..a4dd47acf98a 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -174,8 +174,6 @@
 
 &nand {
 	status = "okay";
-	pinctrl-0 = <&pmx_nand>;
-	pinctrl-names = "default";
 
 	partition at 0 {
 		label = "u-boot";
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 0c8d8fa29926..caafcde88f67 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -61,6 +61,8 @@
 			chip-delay = <25>;
 			/* set partition map and/or chip-delay in board dts */
 			clocks = <&gate_clk 7>;
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
 			status = "disabled";
 		};
 	};
-- 
1.9.1
