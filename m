From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  3 Apr 2017 11:14:30 +0200
Subject: [PATCH v3 06/20] ARM: dts: sunxi-h3-h5: Add dt node for the syscon
 control module
In-Reply-To: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
Message-ID: <20170403091444.29876-7-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the dt node for the syscon register present on the
Allwinner H3/H5

Only two register are present in this syscon and the only one useful is
the one dedicated to EMAC clock..

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 6640ebfa..0815c00 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -102,6 +102,12 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 01c00000 {
+			compatible = "allwinner,sun8i-h3-system-controller",
+				"syscon";
+			reg = <0x01c00000 0x1000>;
+		};
+
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun8i-h3-dma";
 			reg = <0x01c02000 0x1000>;
-- 
2.10.2
