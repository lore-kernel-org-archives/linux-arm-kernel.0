From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 17 Feb 2014 20:00:36 +0000
Subject: [PATCH V2] ARM: dove: dt: revert PMU interrupt controller node
In-Reply-To: <20140207180836.GE8533@titan.lakedaemon.net>
References: <20140207180836.GE8533@titan.lakedaemon.net>
Message-ID: <1392667236-19126-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The corresponding driver didn't make it into v3.14, so we need to remove
the node.  Dove systems fail to boot with the node present and no
driver.

This node will be re-added when the driver makes it to mainline.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Changes from v1:

  - removed the reference to pmu_intc.

Destined for the mvebu/dt-fixes branch for v3.14, node will be re-added once
the driver hits mainline for v3.15

 arch/arm/boot/dts/dove.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 2b76524f4aa7..187fd46b7b5e 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -379,15 +379,6 @@
 				#clock-cells = <1>;
 			};
 
-			pmu_intc: pmu-interrupt-ctrl at d0050 {
-				compatible = "marvell,dove-pmu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				reg = <0xd0050 0x8>;
-				interrupts = <33>;
-				marvell,#interrupts = <7>;
-			};
-
 			pinctrl: pin-ctrl at d0200 {
 				compatible = "marvell,dove-pinctrl";
 				reg = <0xd0200 0x10>;
@@ -610,8 +601,6 @@
 			rtc: real-time-clock at d8500 {
 				compatible = "marvell,orion-rtc";
 				reg = <0xd8500 0x20>;
-				interrupt-parent = <&pmu_intc>;
-				interrupts = <5>;
 			};
 
 			gpio2: gpio-ctrl at e8400 {
-- 
1.8.5.5
