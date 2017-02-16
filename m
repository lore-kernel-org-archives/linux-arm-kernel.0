From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 16 Feb 2017 13:48:53 +0100
Subject: [PATCH 15/21] ARM64: dts: sun50i-a64: Add dt node for the syscon
 control module
In-Reply-To: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
Message-ID: <20170216124859.14346-16-clabbe.montjoie@gmail.com>
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
index 1c64ea2..3b09af2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -121,6 +121,12 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 01c00000 {
+			compatible = "syscon",
+				"allwinner,sun8i-h3-system-controller";
+			reg = <0x01c00000 0x1000>;
+		};
+
 		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun50i-a64-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.10.2
