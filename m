From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 8 Oct 2013 20:20:27 +0200
Subject: [PATCH v2] ARM: Dove: fix bad properties of the si5351 clkout2 used
 by Cubox audio
Message-ID: <20131008202027.6d9f0bd2@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As defined in the DT, clkout2 is not allowed to change the pll inside
si5351.

This patch extends the properties of clkout2 so that it works as the
external clock of the audio device in the Cubox.

Also, as the second si5351 clock is not used in the Cubox, its
definition is removed.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v2:
- remove clkout1 which is not used in the Cubox (Sebastian Hesselbarth)
---
 arch/arm/boot/dts/dove-cubox.dts | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index bb38a24..3dd8844 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -99,18 +99,12 @@
 			silabs,pll-master;
 		};
 
-		clkout1 {
-			reg = <1>;
-			silabs,drive-strength = <8>;
-			silabs,multisynth-source = <1>;
-			silabs,clock-source = <0>;
-			silabs,pll-master;
-		};
-
 		clkout2 {
 			reg = <2>;
+			silabs,drive-strength = <8>;
 			silabs,multisynth-source = <1>;
 			silabs,clock-source = <0>;
+			silabs,pll-master;
 		};
 	};
 };


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
