From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  1 Oct 2012 11:43:42 +0100
Subject: [PATCH 1/7] ARM: ux500: Elaborate on SDI device node names in Device
 Tree
In-Reply-To: <1349088228-8582-1-git-send-email-lee.jones@linaro.org>
References: <1349088228-8582-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349088228-8582-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the DB8500 Reference Manual SDI devices are described as being
part of peripheral blocks. This is more in line with how these devices
are actually represented in hardware, so here we detail which
peripheral block each of the SDI devices belong in the node name.

Requested-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi  |   12 ++++++------
 arch/arm/boot/dts/snowball.dts |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index c8c39dd..07a085b 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -536,37 +536,37 @@
 			status = "disabled";
 		};
 
-		sdi at 80126000 {
+		sdi0_per1 at 80126000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80126000 0x1000>;
 			interrupts = <0 60 0x4>;
 			status = "disabled";
 		};
-		sdi at 80118000 {
+		sdi1_per2 at 80118000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80118000 0x1000>;
 			interrupts = <0 50 0x4>;
 			status = "disabled";
 		};
-		sdi at 80005000 {
+		sdi2_per3 at 80005000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80005000 0x1000>;
 			interrupts = <0 41 0x4>;
 			status = "disabled";
 		};
-		sdi at 80119000 {
+		sdi3_per2 at 80119000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80119000 0x1000>;
 			interrupts = <0 59 0x4>;
 			status = "disabled";
 		};
-		sdi at 80114000 {
+		sdi4_per2 at 80114000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80114000 0x1000>;
 			interrupts = <0 99 0x4>;
 			status = "disabled";
 		};
-		sdi at 80008000 {
+		sdi5_per3 at 80008000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80114000 0x1000>;
 			interrupts = <0 100 0x4>;
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 639b8e9..9a37244 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -120,7 +120,7 @@
 		};
 
 		// External Micro SD slot
-		sdi at 80126000 {
+		sdi0_per1 at 80126000 {
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <50000000>;
 			bus-width = <8>;
@@ -134,7 +134,7 @@
 		};
 
 		// On-board eMMC
-		sdi at 80114000 {
+		sdi4_per2 at 80114000 {
 			arm,primecell-periphid = <0x10480180>;
 		        max-frequency = <50000000>;
 			bus-width = <8>;
-- 
1.7.9.5
