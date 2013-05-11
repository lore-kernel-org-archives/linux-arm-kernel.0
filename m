From: jg1.han@samsung.com (Jingoo Han)
Date: Sat, 11 May 2013 16:42:52 +0900
Subject: [PATCH 1/2] ARM: dts: add DP clock reference to exynos5250 device tree
Message-ID: <003001ce4e1b$24a28fc0$6de7af40$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The transition to common clock happened; however, DP (Display Port)
clock node was not added. Thus, DP (Display Port) clock node should
be added to the device tree.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Tested on Exynos5250

 arch/arm/boot/dts/exynos5250.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 9dfc6de..8b1f9b6 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -651,6 +651,8 @@
 		reg = <0x145b0000 0x1000>;
 		interrupts = <10 3>;
 		interrupt-parent = <&combiner>;
+		clocks = <&clock 342>;
+		clock-names = "dp";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
1.7.2.5
