From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 11 Apr 2014 16:59:40 +0200
Subject: [PATCH 6/6] ARM: dts: sh: drop address cells from GIC node
In-Reply-To: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
References: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1397228380-7352-6-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is likely a copy-and-paste error from the
ARM GIC documentation, that has already been fixed.

address-cells should have been set to 0, as with the size
cells. As having those properties set to 0 is the
same thing as not specifying them, drop them completely.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/r8a7740.dtsi | 1 -
 arch/arm/boot/dts/sh73a0.dtsi  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 8280884bfa59..2551e9438d35 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -28,7 +28,6 @@
 	gic: interrupt-controller at c2800000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
 		interrupt-controller;
 		reg = <0xc2800000 0x1000>,
 		      <0xc2000000 0x1000>;
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index b7bd3b9a6753..5ecf552e1c00 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -34,7 +34,6 @@
 	gic: interrupt-controller at f0001000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
 		interrupt-controller;
 		reg = <0xf0001000 0x1000>,
 		      <0xf0000100 0x100>;
-- 
1.9.1
