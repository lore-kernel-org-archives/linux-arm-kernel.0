From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 14 Dec 2017 19:10:54 +0530
Subject: [PATCH 14/14] ARM: dts: keystone-k2g: Use sdhci-omap programming model
In-Reply-To: <20171214134054.7749-1-kishon@ti.com>
References: <20171214134054.7749-1-kishon@ti.com>
Message-ID: <20171214134054.7749-15-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use sdhci-omap programming model based on the generic sdhci
library for programming the MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 8f313ff406b9..2c6da70eac38 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -349,14 +349,10 @@
 		};
 
 		mmc0: mmc at 23000000 {
-			compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
+			compatible = "ti,k2g-sdhci";
 			reg = <0x23000000 0x400>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>;
-			dmas = <&edma1 24 0>, <&edma1 25 0>;
-			dma-names = "tx", "rx";
 			bus-width = <4>;
-			ti,needs-special-reset;
-			no-1-8-v;
 			max-frequency = <96000000>;
 			power-domains = <&k2g_pds 0xb>;
 			clocks = <&k2g_clks 0xb 1>, <&k2g_clks 0xb 2>;
@@ -365,14 +361,11 @@
 		};
 
 		mmc1: mmc at 23100000 {
-			compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
+			compatible = "ti,k2g-sdhci";
 			reg = <0x23100000 0x400>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_EDGE_RISING>;
-			dmas = <&edma1 26 0>, <&edma1 27 0>;
-			dma-names = "tx", "rx";
 			bus-width = <8>;
-			ti,needs-special-reset;
-			ti,non-removable;
+			non-removable;
 			max-frequency = <96000000>;
 			power-domains = <&k2g_pds 0xc>;
 			clocks = <&k2g_clks 0xc 1>, <&k2g_clks 0xc 2>;
-- 
2.11.0
