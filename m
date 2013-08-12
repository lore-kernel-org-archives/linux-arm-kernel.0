From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 12 Aug 2013 15:37:49 +0530
Subject: [PATCH V4 3/4] ARM: dts: Add osc clock node on smdk5420.
In-Reply-To: <1376302070-1877-1-git-send-email-padma.v@samsung.com>
References: <1376302070-1877-1-git-send-email-padma.v@samsung.com>
Message-ID: <1376302070-1877-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 16MHz oscillator clock node required for audio
on smdk5420 and adds the phandle of the same in wm8994 clock info.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 1ef7e2e..a898b3f 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -31,6 +31,12 @@
 		};
 	};
 
+	osc3_clk16mhz: oscillator-0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16934400>;
+	};
+
 	dwmmc0 at 12200000 {
 		status = "okay";
 		num-slots = <1>;
@@ -127,6 +133,9 @@
 			DBVDD-supply = <&dbvdd>;
 			SPKVDD1-supply = <&spkvdd>;
 			SPKVDD2-supply = <&spkvdd>;
+
+			clocks = <&osc3_clk16mhz>;
+			clock-names = "mclk1";
 		};
 	};
 
-- 
1.7.4.4
