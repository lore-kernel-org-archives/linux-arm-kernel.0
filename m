From: cooloney@gmail.com (Bryan Wu)
Date: Fri,  7 Feb 2014 12:53:32 -0800
Subject: [PATCH] ARM: tegra: enable I2C MUX PCA954x
Message-ID: <1391806412-8561-1-git-send-email-pengw@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cardhu has a PCA9546 for I2C bus extension, which connects to 3
cameras. It's required for Tegra V4L2 soc camera driver and camera
sensor drivers.

Signed-off-by: Bryan Wu <pengw@nvidia.com>
---
 arch/arm/boot/dts/tegra30-cardhu.dtsi | 8 ++++++++
 arch/arm/configs/tegra_defconfig      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 9104224..bfce643 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -187,6 +187,14 @@
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		/* NXP PCA9546 I2C Mux */
+		pca9546 at 70 {
+			compatible = "nxp,pca9546";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x70>;
+		};
 	};
 
 	i2c at 7000c700 {
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 995d434..efcf15f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -125,6 +125,7 @@ CONFIG_SERIAL_TEGRA=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
-- 
1.8.3.2
