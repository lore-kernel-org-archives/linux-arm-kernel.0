From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 15 Oct 2015 18:05:32 +0900
Subject: [PATCH 1/3] ARM: dts: uniphier: change the external bus address
 mapping
In-Reply-To: <1444899934-4754-1-git-send-email-yamada.masahiro@socionext.com>
References: <1444899934-4754-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1444899934-4754-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In UniPhier SoCs before ProXstream2 and PH1-LD6b, two address spaces
 0x00000000 - 0x0fffffff
 0x40000000 - 0x4fffffff
are both mapped to the external bus (also called system bus),
so either was OK.

In the newest two SoCs, the former (0x00000000 - 0x0fffffff) is
assigned for the serial NOR interface.

For the consistency, use the latter for all the SoCs.

Also, fix the range properties to reflect the real address mapping,
where the support card is located at the offset address 0x01f00000
of CS1 of the external bus.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts  | 5 ++---
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts | 5 ++---
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts | 5 ++---
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts | 5 ++---
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts | 5 ++---
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
index bfd3bb8..e9722a5 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
@@ -74,12 +74,11 @@
 };
 
 &extbus {
-	ranges = <0 0x00000000 0x0f000000 0x01000000
-		  1 0x00000000 0x00000000 0x08000000>;
+	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
 &support_card {
-	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+	ranges = <0x00000000 1 0x01f00000 0x00100000>;
 };
 
 &ethsc {
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
index 3a6f1f6..1a402ed 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
@@ -76,12 +76,11 @@
 };
 
 &extbus {
-	ranges = <0 0x00000000 0x0f000000 0x01000000
-		  1 0x00000000 0x00000000 0x08000000>;
+	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
 &support_card {
-	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+	ranges = <0x00000000 1 0x01f00000 0x00100000>;
 };
 
 &ethsc {
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
index 69a5b7d..47e2edb 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
@@ -76,12 +76,11 @@
 };
 
 &extbus {
-	ranges = <0 0x00000000 0x0f000000 0x01000000
-		  1 0x00000000 0x00000000 0x08000000>;
+	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
 &support_card {
-	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+	ranges = <0x00000000 1 0x01f00000 0x00100000>;
 };
 
 &ethsc {
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
index 1a440f8..adcbbc6 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
@@ -75,12 +75,11 @@
 };
 
 &extbus {
-	ranges = <0 0x00000000 0x0f000000 0x01000000
-		  1 0x00000000 0x00000000 0x08000000>;
+	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
 &support_card {
-	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+	ranges = <0x00000000 1 0x01f00000 0x00100000>;
 };
 
 &ethsc {
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
index 955d417..bcf2e7c 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
@@ -74,12 +74,11 @@
 };
 
 &extbus {
-	ranges = <0 0x00000000 0x0f000000 0x01000000
-		  1 0x00000000 0x00000000 0x08000000>;
+	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
 &support_card {
-	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+	ranges = <0x00000000 1 0x01f00000 0x00100000>;
 };
 
 &ethsc {
-- 
1.9.1
