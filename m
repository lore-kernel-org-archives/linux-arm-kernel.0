From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 28 Dec 2016 00:51:26 +0900
Subject: [PATCH] ARM, ARM64: dts: drop "arm,
 amba-bus" in favor of "simple-bus" part 3
Message-ID: <1482853886-7932-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tree-wide replacement was done by commit 2ef7d5f342c1 ("ARM, ARM64:
dts: drop "arm,amba-bus" in favor of "simple-bus"), then the 2nd
round by commit 15b7cc78f095 ("arm64: dts: drop "arm,amba-bus" in
favor of "simple-bus" part 2").

Here, some new users have appeared for Linux v4.10-rc1.  Eliminate
them now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Hi Arnd, Olof,

Can you pick this up for v4.10 fixes?

If we carry arm,amba-bus until the release, we will need to
take more time to deprecate it.


 arch/arm/boot/dts/qcom-mdm9615.dtsi        | 2 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 5ae4ec5..c852b69 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -357,7 +357,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 64226d5..135890c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1367,7 +1367,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.7.4
