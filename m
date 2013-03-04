From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 04 Mar 2013 11:04:27 +0530
Subject: [PATCH 1/2] ARM: exynos: pl330: Add #dma-cells for generic dma binding
 support
Message-ID: <1362375268-29405-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds #dma-cells property to PL330 DMA controller
nodes for supporting generic dma dt bindings on samsung exynos
platforms. #dma-channels and #dma-requests are not required now
but added in advance.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

Based on Torvalds tree

 arch/arm/boot/dts/exynos4.dtsi    |    9 +++++++++
 arch/arm/boot/dts/exynos5440.dtsi |    6 ++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e1347fc..1a62bcf 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -275,18 +275,27 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12680000 0x1000>;
 			interrupts = <0 35 0>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		pdma1: pdma at 12690000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12690000 0x1000>;
 			interrupts = <0 36 0>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		mdma1: mdma at 12850000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12850000 0x1000>;
 			interrupts = <0 34 0>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 5f3562a..9a99755 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -142,12 +142,18 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x120000 0x1000>;
 			interrupts = <0 34 0>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		pdma1: pdma at 121B0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121000 0x1000>;
 			interrupts = <0 35 0>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 	};
 
-- 
1.7.4.4
