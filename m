From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Tue, 22 Apr 2014 22:05:26 +0900
Subject: [PATCH v2] ARM: dts: disable MDMA1 node for Exynos5420
Message-ID: <000a01cf5e2b$87601760$96204620$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change places MDMA1 in disabled node for Exynos5420.
If MDMA1 region is configured with secure mode, it makes
the boot failure with the following on smdk5420 board.
("Unhandled fault: imprecise external abort (0x1406) at 0x00000000")
Thus, arndale-octa board don't need to do the same thing anymore.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Note: This patch comes from "[PATCH] ARM: dts: disable MDMA1 node for smdk5420 board"

 arch/arm/boot/dts/exynos5420-arndale-octa.dts |   12 ------------
 arch/arm/boot/dts/exynos5420.dtsi             |    7 +++++++
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 80a3bf4..896a2a6 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -364,16 +364,4 @@
 			gpio-key,wakeup;
 		};
 	};
-
-	amba {
-		mdma1: mdma at 11C10000 {
-			/*
-			 * MDMA1 can support both secure and non-secure
-			 * AXI transactions. When this is enabled in the kernel
-			 * for boards that run in secure mode, we are getting
-			 * imprecise external aborts causing the kernel to oops.
-			 */
-			status = "disabled";
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c3a9a66..97cbcdd 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -336,6 +336,13 @@
 			#dma-cells = <1>;
 			#dma-channels = <8>;
 			#dma-requests = <1>;
+			/*
+			 * MDMA1 can support both secure and non-secure
+			 * AXI transactions. When this is enabled in the kernel
+			 * for boards that run in secure mode, we are getting
+			 * imprecise external aborts causing the kernel to oops.
+			 */
+			status = "disabled";
 		};
 	};
 
-- 
1.7.0.4
