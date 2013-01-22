From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 22 Jan 2013 11:28:45 +0100
Subject: [PATCH] Dove: activate GPIO interrupts in DT
Message-ID: <20130122112845.4f7c0f38@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a DT, the interrupts of an interrupt-controller are not usable when
#interrupt-cells is missing.

This patch activates the interrupts of the GPIOs 0 and 1 for the Marvell
Dove SoC.

Signed-off-by: Jean-Fran?ois Moine <moinejf@free.fr>

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 42eac1f..287fb12 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -93,6 +93,7 @@
 			reg = <0xd0400 0x20>;
 			ngpios = <32>;
 			interrupt-controller;
+			#interrupt-cells = <1>;
 			interrupts = <12>, <13>, <14>, <60>;
 		};
 
@@ -103,6 +104,7 @@
 			reg = <0xd0420 0x20>;
 			ngpios = <32>;
 			interrupt-controller;
+			#interrupt-cells = <1>;
 			interrupts = <61>;
 		};
 
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
