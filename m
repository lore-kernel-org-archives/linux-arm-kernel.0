From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Sat,  6 Sep 2014 11:54:43 +0300
Subject: [PATCH v3 3/5] ARM: tegra124: Add I2C controller ids to device tree
In-Reply-To: <1409993685-21911-1-git-send-email-cyndis@kapsi.fi>
References: <1409993685-21911-1-git-send-email-cyndis@kapsi.fi>
Message-ID: <1409993685-21911-4-git-send-email-cyndis@kapsi.fi>
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
index a7608a4..65daa9e 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -356,6 +356,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 21>, <&apbdma 21>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <0>;
 		status = "disabled";
 	};
 
@@ -371,6 +372,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 22>, <&apbdma 22>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <1>;
 		status = "disabled";
 	};
 
@@ -386,6 +388,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 23>, <&apbdma 23>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <2>;
 		status = "disabled";
 	};
 
@@ -401,6 +404,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 26>, <&apbdma 26>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <3>;
 		status = "disabled";
 	};
 
@@ -416,6 +420,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 24>, <&apbdma 24>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <4>;
 		status = "disabled";
 	};
 
@@ -431,6 +436,7 @@
 		reset-names = "i2c";
 		dmas = <&apbdma 30>, <&apbdma 30>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <5>;
 		status = "disabled";
 	};
 
-- 
2.1.0
