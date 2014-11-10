From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Mon, 10 Nov 2014 15:12:15 +0200
Subject: [PATCH v4 REPOST 3/5] ARM: tegra124: Add I2C controller ids to device
 tree
In-Reply-To: <1415625137-4791-1-git-send-email-mikko.perttunen@kapsi.fi>
References: <1415625137-4791-1-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <1415625137-4791-4-git-send-email-mikko.perttunen@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

I2C controller ids are required when programming hardware blocks
that send messages to devices connected to an I2C bus, such as
when the PMC sends a poweroff message to the PMIC. Add ids
to all I2C controllers in Tegra124.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Wei Ni <wni@nvidia.com>
Tested-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 41f8b27..0f09e93 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -361,6 +361,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 21>, <&apbdma 21>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <0>;
 		status = "disabled";
 	};
 
@@ -376,6 +377,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 22>, <&apbdma 22>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <1>;
 		status = "disabled";
 	};
 
@@ -391,6 +393,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 23>, <&apbdma 23>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <2>;
 		status = "disabled";
 	};
 
@@ -406,6 +409,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 26>, <&apbdma 26>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <3>;
 		status = "disabled";
 	};
 
@@ -421,6 +425,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 24>, <&apbdma 24>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <4>;
 		status = "disabled";
 	};
 
@@ -436,6 +441,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 30>, <&apbdma 30>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <5>;
 		status = "disabled";
 	};
 
-- 
2.1.3
