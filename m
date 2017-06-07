From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 7 Jun 2017 15:07:47 +0530
Subject: [PATCH v2 6/8] ARM: dts: dra7: Add "max-frequency" property to MMC dt
 nodes
In-Reply-To: <20170607093749.15656-1-kishon@ti.com>
References: <20170607093749.15656-1-kishon@ti.com>
Message-ID: <20170607093749.15656-7-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "max-frequency" property to MMC dt nodes and set the
maximum frequency to 192MHz for MMC1/MMC2, 64MHz for MMC3
and 192MHz for MMC4. pdata quirks must be utilized to
detect presence of rev 1.1/1.0 of silicon and adjust
maximum frequencies as per restrictions documented in i843.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e7144662af45..c09a91e77f53 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1037,6 +1037,7 @@
 			dma-names = "tx", "rx";
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
+			max-frequency = <192000000>;
 		};
 
 		mmc2: mmc at 480b4000 {
@@ -1048,6 +1049,7 @@
 			dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			max-frequency = <192000000>;
 		};
 
 		mmc3: mmc at 480ad000 {
@@ -1059,6 +1061,8 @@
 			dmas = <&sdma_xbar 77>, <&sdma_xbar 78>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			/* Errata i887 limits max-frequency of MMC3 to 64 MHz */
+			max-frequency = <64000000>;
 		};
 
 		mmc4: mmc at 480d1000 {
@@ -1070,6 +1074,7 @@
 			dmas = <&sdma_xbar 57>, <&sdma_xbar 58>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			max-frequency = <192000000>;
 		};
 
 		mmu0_dsp1: mmu at 40d01000 {
-- 
2.11.0
