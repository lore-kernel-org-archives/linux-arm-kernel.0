From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 16:03:21 +0200
Subject: [PATCH 3/7] ARM: exynos: add missing properties for combiner IRQs
In-Reply-To: <1365775405-115297-1-git-send-email-arnd@arndb.de>
References: <1365775405-115297-1-git-send-email-arnd@arndb.de>
Message-ID: <1365775405-115297-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos combiner irqchip needs to find the parent interrupts
and needs to know their number, so add the missing properties
for exynos4 as they were already present for exynos5.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/exynos4210.dtsi | 1 +
 arch/arm/boot/dts/exynos4212.dtsi | 9 +++++++++
 arch/arm/boot/dts/exynos4412.dtsi | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 15143bd..c102869 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -41,6 +41,7 @@
 	};
 
 	combiner:interrupt-controller at 10440000 {
+		combiner-nr = <16>;
 		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
 			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
 			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 36d4299..f83c3c1 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -26,6 +26,15 @@
 		cpu-offset = <0x8000>;
 	};
 
+	interrupt-controller at 10440000 {
+                combiner-nr = <18>;
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
+			     <0 107 0>, <0 108 0>;
+	};
+
 	mct at 10050000 {
 		compatible = "samsung,exynos4412-mct";
 		reg = <0x10050000 0x800>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index d75c047..4cb657e 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -26,6 +26,15 @@
 		cpu-offset = <0x4000>;
 	};
 
+	interrupt-controller at 10440000 {
+		combiner-nr = <20>;
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
+			     <0 107 0>, <0 108 0>>, <0 48 0>, <0 42 0>;
+	};
+
 	mct at 10050000 {
 		compatible = "samsung,exynos4412-mct";
 		reg = <0x10050000 0x800>;
-- 
1.8.1.2
