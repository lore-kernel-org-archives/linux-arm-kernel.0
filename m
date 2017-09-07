From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 07 Sep 2017 18:39:02 +0900
Subject: [PATCH v2 2/3] ARM: dts: exynos: Add clean name of compatible.
In-Reply-To: <1504777143-29834-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1504777143-29834-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170907093912epcas2p2c012de3af3915a58d889c2d48e283705@epcas2p2.samsung.com>
Message-ID: <1504777143-29834-3-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos 5250 and 5420 have different hardware rotation limits. However,
currently it uses only one compatible - "exynos5-gsc". Since we have
to distinguish between these two, we add different compatible.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 8 ++++----
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 8dbeb87..f795c76 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -637,7 +637,7 @@
 		};
 
 		gsc_0:  gsc at 13e00000 {
-			compatible = "samsung,exynos5-gsc";
+			compatible = "samsung,exynos5-gsc", samsung,exynos5250-gsc";
 			reg = <0x13e00000 0x1000>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_gsc>;
@@ -647,7 +647,7 @@
 		};
 
 		gsc_1:  gsc at 13e10000 {
-			compatible = "samsung,exynos5-gsc";
+			compatible = "samsung,exynos5-gsc", samsung,exynos5250-gsc";
 			reg = <0x13e10000 0x1000>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_gsc>;
@@ -657,7 +657,7 @@
 		};
 
 		gsc_2:  gsc at 13e20000 {
-			compatible = "samsung,exynos5-gsc";
+			compatible = "samsung,exynos5-gsc", samsung,exynos5250-gsc";
 			reg = <0x13e20000 0x1000>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_gsc>;
@@ -667,7 +667,7 @@
 		};
 
 		gsc_3:  gsc at 13e30000 {
-			compatible = "samsung,exynos5-gsc";
+			compatible = "samsung,exynos5-gsc", samsung,exynos5250-gsc";
 			reg = <0x13e30000 0x1000>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_gsc>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 02d2f89..86afe77 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -658,7 +658,7 @@
 		};
 
 		gsc_0: video-scaler at 13e00000 {
-			compatible = "samsung,exynos5-gsc";
+			compatible = "samsung,exynos5-gsc", "samsung,exynos5420-gsc";
 			reg = <0x13e00000 0x1000>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_GSCL0>;
@@ -668,7 +668,7 @@
 		};
 
 		gsc_1: video-scaler at 13e10000 {
-			compatible = "samsung,exynos5-gsc";
+			compatible = "samsung,exynos5-gsc", "samsung,exynos5420-gsc";
 			reg = <0x13e10000 0x1000>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_GSCL1>;
-- 
1.9.1
