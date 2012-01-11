From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 16:09:55 -0700
Subject: [PATCH V2 2/4] ARM: dt: tegra: Modify I2S nodes to match binding
In-Reply-To: <1326323397-23931-1-git-send-email-swarren@nvidia.com>
References: <1326323397-23931-1-git-send-email-swarren@nvidia.com>
Message-ID: <1326323397-23931-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adjust the dma-channel property name to match the binding implemented by
the driver. The binding was implemented and documented in a
separate change to the ASoC tree.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Adjusted property name to match comments during review of ASoC-side
changes.
---
 arch/arm/boot/dts/tegra20.dtsi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 0a5d092..b8e27a3 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -69,14 +69,14 @@
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002800 0x200>;
 		interrupts = < 0 13 0x04 >;
-		dma-channel = < 2 >;
+		nvidia,dma-request-selector = < &apbdma 2 >;
 	};
 
 	i2s at 70002a00 {
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002a00 0x200>;
 		interrupts = < 0 3 0x04 >;
-		dma-channel = < 1 >;
+		nvidia,dma-request-selector = < &apbdma 1 >;
 	};
 
 	das at 70000c00 {
-- 
1.7.0.4
