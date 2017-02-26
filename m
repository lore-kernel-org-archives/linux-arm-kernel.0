From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 26 Feb 2017 14:04:09 +0900
Subject: [PATCH 3/3] arm64: dts: uniphier: fix no unit name warnings
In-Reply-To: <1488085449-28922-1-git-send-email-yamada.masahiro@socionext.com>
References: <1488085449-28922-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1488085449-28922-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warnings reported when built with W=1:
  Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi    | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index 7168cf8..1b96e24 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -52,7 +52,7 @@
 	model = "UniPhier LD11 Reference Board";
 	compatible = "socionext,uniphier-ld11-ref", "socionext,uniphier-ld11";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index da881f5..2ed35e3 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -140,7 +140,7 @@
 			     <1 10 4>;
 	};
 
-	soc {
+	soc at 0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 609162a..8cb0f11 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -52,7 +52,7 @@
 	model = "UniPhier LD20 Reference Board";
 	compatible = "socionext,uniphier-ld20-ref", "socionext,uniphier-ld20";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0 0x80000000 0 0xc0000000>;
 	};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a6b3a70..96c053f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -209,7 +209,7 @@
 			     <1 10 4>;
 	};
 
-	soc {
+	soc at 0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.7.4
