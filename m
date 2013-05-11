From: jg1.han@samsung.com (Jingoo Han)
Date: Sat, 11 May 2013 16:43:56 +0900
Subject: [PATCH 2/2] ARM: dts: Document DP clock in samsung, exynos5-dp binding
Message-ID: <003101ce4e1b$4acc0050$e06400f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos5-dp node needs a clock specified using the common clock
framework.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Tested on Exynos5250

 .../devicetree/bindings/video/exynos_dp.txt        |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
index c60da67..84f10c1 100644
--- a/Documentation/devicetree/bindings/video/exynos_dp.txt
+++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
@@ -21,6 +21,10 @@ Required properties for dp-controller:
 		of memory mapped region.
 	-interrupts:
 		interrupt combiner values.
+	-clocks:
+		from common clock binding: handle to dp clock.
+	-clock-names:
+		from common clock binding: Shall be "dp".
 	-interrupt-parent:
 		phandle to Interrupt combiner node.
 	-samsung,color-space:
@@ -61,6 +65,8 @@ SOC specific portion:
 		reg = <0x145b0000 0x10000>;
 		interrupts = <10 3>;
 		interrupt-parent = <&combiner>;
+		clocks = <&clock 342>;
+		clock-names = "dp";
 
 		dptx-phy {
 			reg = <0x10040720>;
-- 
1.7.2.5
