From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 15:52:42 +0200
Subject: [PATCH 2/8] ARM: dts: exynos4: Drop interrupt controller properties
 from MCT nodes
In-Reply-To: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
References: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377006768-23174-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MCT is not an interrupt controller and so there is no point for device
tree nodes representing it to contain interrupt-controller
and #interrupt-cells properties.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 2 --
 arch/arm/boot/dts/exynos4212.dtsi | 2 --
 arch/arm/boot/dts/exynos4412.dtsi | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 057d682..1a6440ae6 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -51,8 +51,6 @@
 	mct at 10050000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x10050000 0x800>;
-		interrupt-controller;
-		#interrups-cells = <2>;
 		interrupt-parent = <&mct_map>;
 		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
 			     <4 0>, <5 0>;
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 6f34d7f..028752e 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -38,8 +38,6 @@
 	mct at 10050000 {
 		compatible = "samsung,exynos4412-mct";
 		reg = <0x10050000 0x800>;
-		interrupt-controller;
-		#interrups-cells = <2>;
 		interrupt-parent = <&mct_map>;
 		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
 			     <4 0>, <5 0>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index e743e67..85d2c26 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -38,8 +38,6 @@
 	mct at 10050000 {
 		compatible = "samsung,exynos4412-mct";
 		reg = <0x10050000 0x800>;
-		interrupt-controller;
-		#interrups-cells = <2>;
 		interrupt-parent = <&mct_map>;
 		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
 			     <4 0>, <5 0>, <6 0>, <7 0>;
-- 
1.8.3.2
