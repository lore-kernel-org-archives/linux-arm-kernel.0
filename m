From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 30 Jun 2017 10:22:28 +0200
Subject: [PATCH] arm64: dts: renesas: Move CPG_AUDIO_CLK_I from board to soc
 files
Message-ID: <1498810948-17910-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of CPG_AUDIO_CLK_I is SoC-specific, not board-specific.
Hence move it from the board-specific .dts files to the SoC-specific
.dtsi files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I don't think it's worth adding Fixes tags.

If you disagree, feel free to add:

Fixes: 79e3b5cf035e4734 ("arm64: dts: renesas: Add support for Salvator-XS with R-Car H3 ES2.0")
Fixes: fb5202dbebfd8fbf ("arm64: dts: r8a7795: h3ulcb: Add support for R-Car H3 ES2.0")
Fixes: 0b03c32db03d63de ("arm64: dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0")
Fixes: 253ed045a34d16d9 ("arm64: dts: renesas: Extract common ULCB board support")
Fixes: d25e8ff0d5aaf8b1 ("arm64: dts: renesas: Extract common Salvator-X board support")
---
 arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts     | 2 --
 arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts | 2 --
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts         | 2 --
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts     | 2 --
 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts    | 2 --
 arch/arm64/boot/dts/renesas/r8a7795.dtsi               | 2 ++
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts         | 2 --
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts     | 2 --
 arch/arm64/boot/dts/renesas/r8a7796.dtsi               | 2 ++
 9 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts
index 95fe207cb6a3fd2f..dd4f9b6a42546def 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts
@@ -9,8 +9,6 @@
  * kind, whether express or implied.
  */
 
-#define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
-
 /dts-v1/;
 #include "r8a7795-es1.dtsi"
 #include "ulcb.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
index b84c156ed6969947..3f7d5f51e42878cb 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
@@ -8,8 +8,6 @@
  * kind, whether express or implied.
  */
 
-#define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
-
 /dts-v1/;
 #include "r8a7795-es1.dtsi"
 #include "salvator-x.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index 0426f41765f0bc68..27d4b1a4c4754732 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -9,8 +9,6 @@
  * kind, whether express or implied.
  */
 
-#define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
-
 /dts-v1/;
 #include "r8a7795.dtsi"
 #include "ulcb.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 684fb3b9d154559e..17953070f38dff8d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -8,8 +8,6 @@
  * kind, whether express or implied.
  */
 
-#define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
-
 /dts-v1/;
 #include "r8a7795.dtsi"
 #include "salvator-x.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index de354957144b4822..6a7d1b22d0fecc9c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -8,8 +8,6 @@
  * kind, whether express or implied.
  */
 
-#define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
-
 /dts-v1/;
 #include "r8a7795.dtsi"
 #include "salvator-xs.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 5ec03641d9873f22..6b75d4b9ce7efa49 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -12,6 +12,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/r8a7795-sysc.h>
 
+#define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
+
 / {
 	compatible = "renesas,r8a7795";
 	#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index 38b58b7fca4bf0e9..1ff9dffae4618a5a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -9,8 +9,6 @@
  * kind, whether express or implied.
  */
 
-#define CPG_AUDIO_CLK_I		R8A7796_CLK_S0D4
-
 /dts-v1/;
 #include "r8a7796.dtsi"
 #include "ulcb.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index db4f162d6bdd2c42..b35b15914771af86 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -8,8 +8,6 @@
  * kind, whether express or implied.
  */
 
-#define CPG_AUDIO_CLK_I		R8A7796_CLK_S0D4
-
 /dts-v1/;
 #include "r8a7796.dtsi"
 #include "salvator-x.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index cfb37d4bd65914b4..49b9f2c05f71cd05 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -12,6 +12,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/r8a7796-sysc.h>
 
+#define CPG_AUDIO_CLK_I		R8A7796_CLK_S0D4
+
 / {
 	compatible = "renesas,r8a7796";
 	#address-cells = <2>;
-- 
2.7.4
