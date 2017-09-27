From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 27 Sep 2017 09:34:10 +0200
Subject: [PATCH v6 07/11] arm64: dts: allwinner: add snps,
 dwmac-mdio compatible to emac/mdio
In-Reply-To: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
Message-ID: <20170927073414.17361-8-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stmmac bindings docs said that its mdio node must have
compatible = "snps,dwmac-mdio";
Since dwmac-sun8i does not have any good reasons to not doing it, all
their MDIO node must have it.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 75494cd90e40..e30476f05802 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -517,6 +517,7 @@
 			#size-cells = <0>;
 
 			mdio: mdio {
+				compatible = "snps,dwmac-mdio";
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
-- 
2.13.5
