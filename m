From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 07 Aug 2013 14:40:14 +0530
Subject: [PATCH V3 5/7] ARM: dts: Add osc clock node on smdk5420.
In-Reply-To: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
Message-ID: <1375866616-5541-6-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 16MHz oscillator clock node required for audio
on smdk5420 and adds the phandle of the same in wm8994 clock info.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index e86c1ae..3c56a91 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -31,6 +31,13 @@
 		};
 	};
 
+	osc3_clk16mhz: clk16mhz {
+		compatible = "osc3_clk16mhz";
+		#clock-cells = <0>;
+		clock-frequency = <16934400>;
+		clock-output-names = "osc3_clk16mhz";
+	};
+
 	dwmmc0 at 12200000 {
 		status = "okay";
 		num-slots = <1>;
@@ -123,6 +130,9 @@
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
