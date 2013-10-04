From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 4 Oct 2013 12:21:05 +0200
Subject: [PATCH] ARM: Dove: fix bad properties of the si5351 clkout2 used by
 Cubox audio
Message-ID: <20131004122105.60f605cd@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As defined in the DT, clkout2 is not allowed to change the pll inside
si5351.

This patch inverts the properties of the clkout{1,2} so that clkout2
may be defined as the external clock of the audio device in the Cubox.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/dove-cubox.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 022646e..5d1ece1 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -101,16 +101,16 @@
 
 		clkout1 {
 			reg = <1>;
-			silabs,drive-strength = <8>;
 			silabs,multisynth-source = <1>;
 			silabs,clock-source = <0>;
-			silabs,pll-master;
 		};
 
 		clkout2 {
 			reg = <2>;
+			silabs,drive-strength = <8>;
 			silabs,multisynth-source = <1>;
 			silabs,clock-source = <0>;
+			silabs,pll-master;
 		};
 	};
 };
