From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Jan 2013 09:38:16 +0100
Subject: [PATCH v2] Dove: activate GPIO interrupts in DT
Message-ID: <20130123093816.5cb73df1@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a DT, the interrupts of an interrupt-controller are not usable when
#interrupt-cells is missing.

This patch activates the interrupts of the GPIOs 0 and 1 for the Marvell
Dove SoC.

Signed-off-by: Jean-Fran?ois Moine <moinejf@free.fr>
---
v2
- gpio-mvebu asks for 2 cells
---
 arch/arm/boot/dts/dove.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 42eac1f..740630f 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -93,6 +93,7 @@
 			reg = <0xd0400 0x20>;
 			ngpios = <32>;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <12>, <13>, <14>, <60>;
 		};
 
@@ -103,6 +104,7 @@
 			reg = <0xd0420 0x20>;
 			ngpios = <32>;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <61>;
 		};
 
 
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
