From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:10 -0700
Subject: [PATCH 02/17] arm/dt: Tegra: Clean up I2S and DAS nodes
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2S and DAS nodes don't have children, and hence don't need to set
address/size cells. Also, adjust the dma-channel property name to match
the binding that will be implemented in the driver.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 795b921..6a17240 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -45,26 +45,20 @@
 	};
 
 	i2s at 70002800 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002800 0x200>;
 		interrupts = < 45 >;
-		dma-channel = < 2 >;
+		nvidia,dma-channels = < 2 >;
 	};
 
 	i2s at 70002a00 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002a00 0x200>;
 		interrupts = < 35 >;
-		dma-channel = < 1 >;
+		nvidia,dma-channels = < 1 >;
 	};
 
 	das at 70000c00 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra20-das";
 		reg = <0x70000c00 0x80>;
 	};
-- 
1.7.0.4
