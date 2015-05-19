From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 May 2015 15:20:45 +0200
Subject: [PATCH v7 25/25] ARM: dts: exynos: add iommu reserved regions for
 bootloader's splash screen
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1432041645-11172-26-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some bootloaders enable FIMD module and configure it as a simple
framebuffer to display boot logo or splash screen before booting the
kernel. Such framebuffer stays enabled until proper kernel driver gets
probbed. Usually it is configured in such a way, that it performs DMA
from the buffer located in system memory. To avoid IOMMU access fault
during system boot, additional identity mapping between system memory
and IO virtual address space must be created when IOMMU driver gets
enabled.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts         | 1 +
 arch/arm/boot/dts/exynos4210-trats.dts          | 1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 1 +
 arch/arm/boot/dts/exynos4412-trats2.dts         | 1 +
 arch/arm/boot/dts/exynos5250-snow.dts           | 1 +
 arch/arm/boot/dts/exynos5250-spring.dts         | 1 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts      | 1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts       | 1 +
 8 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 0b9906880c0c..71641f47f6bb 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -203,6 +203,7 @@
 
 &fimd {
 	status = "okay";
+	iommu-reserved-mapping = <0x40000000 0x40000000 0x1ff00000>;
 
 	i80-if-timings {
 		cs-setup = <0>;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 32c5fd8f6269..becc84b881a6 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -424,6 +424,7 @@
 
 	fimd at 11c00000 {
 		status = "okay";
+		iommu-reserved-mapping = <0x40000000 0x40000000 0x40000000>;
 	};
 
 	tmu at 100C0000 {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index d4f2b11319dd..ecc95263ff4c 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -450,6 +450,7 @@
 		pinctrl-0 = <&lcd_clk>, <&lcd_data24>;
 		pinctrl-names = "default";
 		status = "okay";
+		iommu-reserved-mapping = <0x40000000 0x40000000 0x20000000>;
 		samsung,invert-vden;
 		samsung,invert-vclk;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 173ffa479ad3..78532629f396 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -758,6 +758,7 @@
 
 	fimd at 11c00000 {
 		status = "okay";
+		iommu-reserved-mapping = <0x40000000 0x40000000 0x40000000>;
 	};
 
 	camera: camera {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 1eca97ee4bd6..236b953077ac 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -286,6 +286,7 @@
 
 &fimd {
 	status = "okay";
+	iommu-reserved-mapping = <0x40000000 0x40000000 0x80000000>;
 	samsung,invert-vclk;
 };
 
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index d03f9b8d376d..334d98925d4b 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -84,6 +84,7 @@
 
 &fimd {
 	status = "okay";
+	iommu-reserved-mapping = <0x40000000 0x40000000 0x80000000>;
 	samsung,invert-vclk;
 };
 
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 146e71118a72..72442e120d46 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -166,6 +166,7 @@
 
 &fimd {
 	status = "okay";
+	iommu-reserved-mapping = <0x20000000 0x20000000 0x80000000>;
 	samsung,invert-vclk;
 };
 
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 02eb8b15374f..005d2941be93 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -153,6 +153,7 @@
 
 &fimd {
 	status = "okay";
+	iommu-reserved-mapping = <0x20000000 0x20000000 0x80000000>;
 	samsung,invert-vclk;
 };
 
-- 
1.9.2
