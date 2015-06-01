From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 01 Jun 2015 12:10:48 +0200
Subject: [PATCH 4/6] ARM: dts: exynos4415: add sysmmu nodes
In-Reply-To: <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1433153450-3680-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds System MMU nodes to all defined devices that are specific
to Exynos4415 series.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4415.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
index 6a83d7999d8a..ad764842fff5 100644
--- a/arch/arm/boot/dts/exynos4415.dtsi
+++ b/arch/arm/boot/dts/exynos4415.dtsi
@@ -249,6 +249,7 @@
 			clocks = <&cmu CLK_SCLK_FIMD0>, <&cmu CLK_FIMD0>;
 			clock-names = "sclk_fimd", "fimd";
 			samsung,power-domain = <&pd_lcd0>;
+			iommus = <&sysmmu_fimd0>;
 			samsung,sysreg = <&sysreg_system_controller>;
 			status = "disabled";
 		};
@@ -268,6 +269,16 @@
 			status = "disabled";
 		};
 
+		sysmmu_fimd0: sysmmu at 11E20000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x11e20000 0x1000>;
+			interrupts = <0 80 0>, <0 81 0>;
+			clock-names = "sysmmu", "master";
+			clocks = <&cmu CLK_SMMUFIMD0>, <&cmu CLK_FIMD0>;
+			power-domains = <&pd_lcd0>;
+			#iommu-cells = <0>;
+		};
+
 		hsotg: hsotg at 12480000 {
 			compatible = "samsung,s3c6400-hsotg";
 			reg = <0x12480000 0x20000>;
-- 
1.9.2
