From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 11 May 2017 13:58:54 +0200
Subject: [PATCH v3 3/3] arm64: dts: r8a7795: h3ulcb: Add support for R-Car H3
 ES2.0
In-Reply-To: <1494503934-23367-1-git-send-email-geert+renesas@glider.be>
References: <1494503934-23367-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1494503934-23367-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split off support for H3ULCB boards with the ES1.x revision of the R-Car
H3 SoC into a separate file.  The main r8a7795-h3ulcb.dts file now
corresponds to H3ULCB with R-Car H3 ES2.0 or later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 arch/arm64/boot/dts/renesas/Makefile                                  | 2 +-
 .../boot/dts/renesas/{r8a7795-h3ulcb.dts => r8a7795-es1-h3ulcb.dts}   | 0
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts                        | 4 ++--
 3 files changed, 3 insertions(+), 3 deletions(-)
 copy arch/arm64/boot/dts/renesas/{r8a7795-h3ulcb.dts => r8a7795-es1-h3ulcb.dts} (100%)

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index b6c723d8f6875f2d..d5451015950e3dfc 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,5 +1,5 @@
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
-dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-salvator-x.dtb
+dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-salvator-x.dtb r8a7795-es1-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 
 always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts
similarity index 100%
copy from arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
copy to arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index 95fe207cb6a3fd2f..0426f41765f0bc68 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -12,11 +12,11 @@
 #define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
 
 /dts-v1/;
-#include "r8a7795-es1.dtsi"
+#include "r8a7795.dtsi"
 #include "ulcb.dtsi"
 
 / {
-	model = "Renesas H3ULCB board based on r8a7795 ES1.x";
+	model = "Renesas H3ULCB board based on r8a7795 ES2.0+";
 	compatible = "renesas,h3ulcb", "renesas,r8a7795";
 
 	memory at 48000000 {
-- 
2.7.4
