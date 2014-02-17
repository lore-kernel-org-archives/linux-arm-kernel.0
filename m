From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 17 Feb 2014 19:24:33 +0000
Subject: [RESEND PATCH] ARM: dove: dt: revert PMU interrupt controller node
In-Reply-To: <20140207180836.GE8533@titan.lakedaemon.net>
References: <20140207180836.GE8533@titan.lakedaemon.net>
Message-ID: <1392665073-25831-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The corresponding driver didn't make it into v3.14, so we need to remove
the node.  Dove systems fail to boot with the node present and no
driver.

This node will be re-added when the driver makes it to mainline.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Sorry for the resend, infradead.org didn't like the way I specified the list
address.

And after more careful reading, I missed a '>' in my cut-n-paste of Andrew's
email address.  Sorry for the unnecessary noise.

Also, I plan to submit this in mvebu/dt-fixes for v3.14

 arch/arm/boot/dts/dove.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 2b76524f4aa7..967898528062 100644
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
-- 
1.8.5.5
