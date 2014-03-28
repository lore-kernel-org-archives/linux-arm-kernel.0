From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Mar 2014 17:25:51 +0100
Subject: [PATCH 2/2] ARM: dts: imx: drop invalid size and address cells
 properties
In-Reply-To: <1396023951-32383-1-git-send-email-l.stach@pengutronix.de>
References: <1396023951-32383-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1396023951-32383-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those two properties should have been set to zero, which
is the same as not specifying them.

Having address-cells set to 1 causes OF interrupt
mapping routines to add 1 to the interrupt-cells
property and as result fail because all calculations
are off by one.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 --
 arch/arm/boot/dts/imx6sl.dtsi  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2ecb1db..31bd844798a7 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -38,8 +38,6 @@
 	intc: interrupt-controller at 00a01000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		interrupt-controller;
 		reg = <0x00a01000 0x1000>,
 		      <0x00a00100 0x100>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1aaf2d..276425089ea0 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -44,8 +44,6 @@
 	intc: interrupt-controller at 00a01000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		interrupt-controller;
 		reg = <0x00a01000 0x1000>,
 		      <0x00a00100 0x100>;
-- 
1.9.0
