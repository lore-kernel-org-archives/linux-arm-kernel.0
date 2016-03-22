From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 22 Mar 2016 11:00:02 +0900
Subject: [PATCH 1/2] ARM: dts: exynos: Add Security SubSystem node to Exynos4
Message-ID: <1458612003-30284-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Security SubSystem (SSS) node to Exynos4 which provides hardware
acceleration of AES operations.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index c679b3cc3c48..39000f9c6b86 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -969,6 +969,15 @@
 		#iommu-cells = <0>;
 	};
 
+	sss: sss at 10830000 {
+		compatible = "samsung,exynos4210-secss";
+		reg = <0x10830000 0x300>;
+		interrupts = <0 112 0>;
+		clocks = <&clock CLK_SSS>;
+		clock-names = "secss";
+		status = "disabled";
+	};
+
 	prng: rng at 10830400 {
 		compatible = "samsung,exynos4-rng";
 		reg = <0x10830400 0x200>;
-- 
2.5.0
