From: swarren@nvidia.com (Stephen Warren)
Date: Sat, 17 Dec 2011 22:28:20 -0700
Subject: [PATCH 2/3] arm/dt: tegra: Use new compatible value for DVC I2C
 controller
In-Reply-To: <1324186101-23695-1-git-send-email-swarren@nvidia.com>
References: <1324186101-23695-1-git-send-email-swarren@nvidia.com>
Message-ID: <1324186101-23695-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the device tree to indicate which I2C controller is the DVC
controller. AUXDATA needs to be updated too, since the compatible
value changed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
It'd be best to apply this to the same tree as the previous patch. If
that doesn't happen, the DVC I2C driver won't be instantiated due to
the compatible value not being supported. In practice, this isn't an
issue though, since nothing uses the DVC I2C controller yet.

This relies on 0d4f747 "arm/tegra: convert tegra20 to GIC devicetree
binding" for context.

 arch/arm/boot/dts/tegra20.dtsi |    2 +-
 arch/arm/mach-tegra/board-dt.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 660c8ad..3da7afd 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -39,7 +39,7 @@
 	i2c at 7000d000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "nvidia,tegra20-i2c";
+		compatible = "nvidia,tegra20-i2c-dvc";
 		reg = <0x7000D000 0x200>;
 		interrupts = < 0 53 0x04 >;
 	};
diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index b44633b..9abc89d 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -74,7 +74,7 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", TEGRA_I2C_BASE, "tegra-i2c.0", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", TEGRA_I2C2_BASE, "tegra-i2c.1", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", TEGRA_I2C3_BASE, "tegra-i2c.2", NULL),
-	OF_DEV_AUXDATA("nvidia,tegra20-i2c", TEGRA_DVC_BASE, "tegra-i2c.3", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-i2c-dvc", TEGRA_DVC_BASE, "tegra-i2c.3", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S1_BASE, "tegra-i2s.0", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S2_BASE, "tegra-i2s.1", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-das", TEGRA_APB_MISC_DAS_BASE, "tegra-das", NULL),
-- 
1.7.5.4
