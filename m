From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 22 Feb 2018 20:11:10 +0100
Subject: [PATCH 1/2] ARM: dts: exynos: Fix address of PPMU ACP on Exynos4210
Message-ID: <20180222191111.23747-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Typo in unit address of PPMU ACP caused DTC warnings:

    arch/arm/boot/dts/exynos4412-odroidu3.dtb:
        Warning (simple_bus_reg): Node /soc/ppmu_acp at 10ae0000 simple-bus unit address format error, expected "106e0000"

PPMU ACP (under 0x10ae0000 address) is present only in Exynos4210 so
move this node to exynos4210.dtsi with fixing the reg address to proper
one.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4.dtsi    | 6 ------
 arch/arm/boot/dts/exynos4210.dtsi | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 967cd02401c5..909a9f2bf5be 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -821,12 +821,6 @@
 			status = "disabled";
 		};
 
-		ppmu_acp: ppmu_acp at 10ae0000 {
-			compatible = "samsung,exynos-ppmu";
-			reg = <0x106e0000 0x2000>;
-			status = "disabled";
-		};
-
 		ppmu_rightbus: ppmu_rightbus at 112a0000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x112a0000 0x2000>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 853604d91158..88fb47cef9a8 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -162,6 +162,12 @@
 			iommus = <&sysmmu_g2d>;
 		};
 
+		ppmu_acp: ppmu_acp at 10ae0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10ae0000 0x2000>;
+			status = "disabled";
+		};
+
 		ppmu_lcd1: ppmu_lcd1 at 12240000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x12240000 0x2000>;
-- 
2.14.1
