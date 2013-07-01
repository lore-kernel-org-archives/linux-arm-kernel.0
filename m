From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 01 Jul 2013 14:23:19 +0900
Subject: [PATCH V3 1/3] ARM: dts: Add DP PHY node to exynos5250.dtsi
Message-ID: <005201ce761b$1903ff50$4b0bfdf0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PHY provider node for the DP PHY.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 41cd625..7e397c6 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -614,6 +614,12 @@
 		interrupts = <0 94 0>;
 	};
 
+	dp_phy: video-phy at 10040720 {
+		compatible = "samsung,exynos5250-dp-video-phy";
+		reg = <0x10040720 4>;
+		#phy-cells = <0>;
+	};
+
 	dp-controller {
 		compatible = "samsung,exynos5-dp";
 		reg = <0x145b0000 0x1000>;
@@ -623,11 +629,8 @@
 		clock-names = "dp";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		dptx-phy {
-			reg = <0x10040720>;
-			samsung,enable-mask = <1>;
-		};
+		phys = <&dp_phy>;
+		phy-names = "dp";
 	};
 
 	fimd {
-- 
1.7.10.4
