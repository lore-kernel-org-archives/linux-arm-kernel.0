From: cooloney@gmail.com (Bryan Wu)
Date: Fri,  7 Feb 2014 15:54:58 -0800
Subject: [PATCH 2/2] ARM: tegra: enable PCA9546 on Cardhu
In-Reply-To: <1391817298-10600-1-git-send-email-pengw@nvidia.com>
References: <1391817298-10600-1-git-send-email-pengw@nvidia.com>
Message-ID: <1391817298-10600-2-git-send-email-pengw@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cardhu has a PCA9546 for I2C bus extension, which connects to 3
cameras. It's required for Tegra V4L2 soc camera driver and camera
sensor drivers.

Signed-off-by: Bryan Wu <pengw@nvidia.com>
---
 arch/arm/boot/dts/tegra30-cardhu.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 9104224..004002c 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -187,6 +187,13 @@
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		i2cmux at 70 {
+			compatible = "nxp,pca9546";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x70>;
+		};
 	};
 
 	i2c at 7000c700 {
-- 
1.8.3.2
