From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 31 Oct 2017 09:19:15 +0100
Subject: [PATCH v10 8/8] arm64: dts: allwinner: add snps,
 dwmac-mdio compatible to emac/mdio
In-Reply-To: <20171031081915.18960-1-clabbe.montjoie@gmail.com>
References: <20171031081915.18960-1-clabbe.montjoie@gmail.com>
Message-ID: <20171031081915.18960-9-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stmmac bindings docs said that its mdio node must have
compatible = "snps,dwmac-mdio";
Since dwmac-sun8i does not have any good reasons to not doing it, all
their MDIO node must have it.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 0650a1cda107..0a2074f86f2c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -532,6 +532,7 @@
 			#size-cells = <0>;
 
 			mdio: mdio {
+				compatible = "snps,dwmac-mdio";
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
-- 
2.13.6
