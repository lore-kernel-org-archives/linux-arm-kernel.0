From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 13 Aug 2014 15:41:23 +0300
Subject: [PATCH v2 3/5] ARM: tegra124: Add I2C controller ids to device tree
In-Reply-To: <1407933685-12404-1-git-send-email-mperttunen@nvidia.com>
References: <1407933685-12404-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1407933685-12404-4-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C controller ids are required when programming hardware blocks
that send messages to devices connected to an I2C bus, such as
when the PMC sends a poweroff message to the PMIC. Add ids
to all I2C controllers in Tegra124.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 03916ef..a101960 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -289,6 +289,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 21>, <&apbdma 21>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <0>;
 		status = "disabled";
 	};
 
@@ -304,6 +305,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 22>, <&apbdma 22>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <1>;
 		status = "disabled";
 	};
 
@@ -319,6 +321,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 23>, <&apbdma 23>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <2>;
 		status = "disabled";
 	};
 
@@ -334,6 +337,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 26>, <&apbdma 26>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <3>;
 		status = "disabled";
 	};
 
@@ -349,6 +353,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 24>, <&apbdma 24>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <4>;
 		status = "disabled";
 	};
 
@@ -364,6 +369,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 30>, <&apbdma 30>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <5>;
 		status = "disabled";
 	};
 
-- 
1.8.1.5
