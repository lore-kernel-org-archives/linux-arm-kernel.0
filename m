From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 12 Nov 2014 11:50:29 +0900
Subject: [PATCHv2 2/2] ARM: dts: Fix the number of DMA channels for Exynos4
In-Reply-To: <1415760629-1531-1-git-send-email-cw00.choi@samsung.com>
References: <1415760629-1531-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1415760629-1531-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the numer for DMA channels for Exynos4210/Exynos4212/Exynos4412
/Exynos4415 because DMA controller of Exynos4 series can support 16 channels
simultaneously.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 4 ++--
 arch/arm/boot/dts/exynos4415.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e0278ec..3b2c3dd 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -606,7 +606,7 @@
 			clocks = <&clock CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
+			#dma-channels = <16>;
 			#dma-requests = <32>;
 		};
 
@@ -617,7 +617,7 @@
 			clocks = <&clock CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
+			#dma-channels = <16>;
 			#dma-requests = <32>;
 		};
 
diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
index c1c9b37..a097332 100644
--- a/arch/arm/boot/dts/exynos4415.dtsi
+++ b/arch/arm/boot/dts/exynos4415.dtsi
@@ -348,7 +348,7 @@
 				clocks = <&cmu CLK_PDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
-				#dma-channels = <8>;
+				#dma-channels = <16>;
 				#dma-requests = <32>;
 			};
 
@@ -359,7 +359,7 @@
 				clocks = <&cmu CLK_PDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
-				#dma-channels = <8>;
+				#dma-channels = <16>;
 				#dma-requests = <32>;
 			};
 		};
-- 
1.8.5.5
