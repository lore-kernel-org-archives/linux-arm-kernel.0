From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 16:09:56 -0700
Subject: [PATCH V2 3/4] ARM: dt: tegra: Add labels for I2S controllers
In-Reply-To: <1326323397-23931-1-git-send-email-swarren@nvidia.com>
References: <1326323397-23931-1-git-send-email-swarren@nvidia.com>
Message-ID: <1326323397-23931-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow the sound node to refer to the I2S controllers by name
when creating phandles.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index b8e27a3..f1c2a8b 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -65,14 +65,14 @@
 		interrupts = < 0 53 0x04 >;
 	};
 
-	i2s at 70002800 {
+	tegra_i2s1: i2s at 70002800 {
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002800 0x200>;
 		interrupts = < 0 13 0x04 >;
 		nvidia,dma-request-selector = < &apbdma 2 >;
 	};
 
-	i2s at 70002a00 {
+	tegra_i2s2: i2s at 70002a00 {
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002a00 0x200>;
 		interrupts = < 0 3 0x04 >;
-- 
1.7.0.4
