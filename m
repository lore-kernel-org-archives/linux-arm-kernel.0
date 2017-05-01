From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  1 May 2017 14:45:13 +0200
Subject: [PATCH v5 13/20] arm64: allwinner: sun50i-a64: Add dt node for the
 syscon control module
In-Reply-To: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
Message-ID: <20170501124520.3769-14-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the dt node for the syscon register present on the
Allwinner A64.

Only two register are present in this syscon and the only one useful is
the one dedicated to EMAC clock.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index c7f669f..d7341ba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -129,6 +129,12 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 1c00000 {
+			compatible = "allwinner,sun50i-a64-system-controller",
+				"syscon";
+			reg = <0x01c00000 0x1000>;
+		};
+
 		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun50i-a64-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.10.2
