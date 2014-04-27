From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Sun, 27 Apr 2014 13:08:00 +0530
Subject: [PATCH v12 28/31] ARM: dts: add System MMU nodes of exynos4210
In-Reply-To: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1398584283-22846-29-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

This patch adds System MMUs that are specific to exynos4210.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index cacf614..0b4ece1 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -114,7 +114,7 @@
 		status = "disabled";
 	};
 
-	g2d at 12800000 {
+	g2d: g2d at 12800000 {
 		compatible = "samsung,s5pv210-g2d";
 		reg = <0x12800000 0x1000>;
 		interrupts = <0 89 0>;
@@ -153,4 +153,25 @@
 			samsung,lcd-wb;
 		};
 	};
+
+	sysmmu_g2d: sysmmu at 12A20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12A20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 7>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_G2D>;
+		samsung,power-domain = <&pd_lcd0>;
+		mmu-masters = <&g2d>;
+	};
+
+	sysmmu_fimd1: sysmmu at 12220000 {
+		compatible = "samsung,sysmmu-v1";
+		interrupt-parent = <&combiner>;
+		reg = <0x12220000 0x1000>;
+		interrupts = <5 3>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMD1>;
+		samsung,power-domain = <&pd_lcd1>;
+	};
 };
-- 
1.7.9.5
