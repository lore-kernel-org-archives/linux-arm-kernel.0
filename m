From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 14:56:33 +0200
Subject: [PATCH 06/15] ARM: dts: kirkwood: add pinctrl node to common SoC
 include
In-Reply-To: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1398862602-29595-7-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Kirkwood SoCs have their pinctrl registers at the same address.
Instead of replaying the same reg property on each SoC, have the
reg property set in the common SoC file already. This also allows
us to move common pinctrl settings to this node later on.

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
 arch/arm/boot/dts/kirkwood-6192.dtsi     | 1 -
 arch/arm/boot/dts/kirkwood-6281.dtsi     | 1 -
 arch/arm/boot/dts/kirkwood-6282.dtsi     | 1 -
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi | 1 -
 arch/arm/boot/dts/kirkwood.dtsi          | 5 +++++
 5 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
index 4f1eef36a7ac..c008e9a877d5 100644
--- a/arch/arm/boot/dts/kirkwood-6192.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
@@ -37,7 +37,6 @@
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			compatible = "marvell,88f6192-pinctrl";
-			reg = <0x10000 0x20>;
 
 			pmx_nand: pmx-nand {
 				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index d95a7a9cfd1e..3674a9b9552e 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -37,7 +37,6 @@
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			compatible = "marvell,88f6281-pinctrl";
-			reg = <0x10000 0x20>;
 
 			pmx_nand: pmx-nand {
 				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 523d6feeaf19..89a6ba149ec2 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -58,7 +58,6 @@
 
 		pinctrl: pin-controller at 10000 {
 			compatible = "marvell,88f6282-pinctrl";
-			reg = <0x10000 0x20>;
 
 			pmx_nand: pmx-nand {
 				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
index c59e7b75b169..4a2d1b12d1ca 100644
--- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
+++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
@@ -2,7 +2,6 @@
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			compatible = "marvell,98dx4122-pinctrl";
-			reg = <0x10000 0x20>;
 
 			pmx_nand: pmx-nand {
 				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 2570e0f1673f..028003e12111 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -71,6 +71,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		pinctrl: pin-controller at 10000 {
+			/* set compatible property in SoC file */
+			reg = <0x10000 0x20>;
+		};
+
 		core_clk: core-clocks at 10030 {
 			compatible = "marvell,kirkwood-core-clock";
 			reg = <0x10030 0x4>;
-- 
1.9.1
