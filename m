From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  4 Apr 2013 19:46:45 +0900
Subject: [PATCH 2/4] ARM: dts: add PDMA0 changes for exynos5440
In-Reply-To: <1365072407-4320-1-git-send-email-kgene.kim@samsung.com>
References: <1365072407-4320-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1365072407-4320-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subash Patel <subash.rp@samsung.com>

PDMA0 at 0x121000 changes are added into the architecture DTS file.

Signed-off-by: Subash Patel <subash.rp@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 7bd1f3b..715ea15 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -165,22 +165,22 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
-		pdma0: pdma at 121A0000 {
+		pdma0: pdma at 00121000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x120000 0x1000>;
-			interrupts = <0 34 0>;
-			clocks = <&clock 21>;
+			reg = <0x121000 0x1000>;
+			interrupts = <0 46 0>;
+			clocks = <&clock 8>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
 			#dma-channels = <8>;
 			#dma-requests = <32>;
 		};
 
-		pdma1: pdma at 121B0000 {
+		pdma1: pdma at 00120000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x121000 0x1000>;
-			interrupts = <0 35 0>;
-			clocks = <&clock 21>;
+			reg = <0x120000 0x1000>;
+			interrupts = <0 47 0>;
+			clocks = <&clock 8>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
 			#dma-channels = <8>;
-- 
1.7.4.4
