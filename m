From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 13 Jun 2013 19:50:58 +0800
Subject: [PATCH 3/9] ARM: dtsi: imx6q/imx6dl: Add a pinctrl for I2C1
In-Reply-To: <cover.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
Message-ID: <45cc8d1b19d53b1b273ae84e02390ca67607fce0.1371123426.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pinctrl for I2C1 used on imx6q/dl-sabresd.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |    9 +++++++++
 arch/arm/boot/dts/imx6q.dtsi  |    7 +++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 2ecbcbc..06bd544 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -112,6 +112,15 @@
 					};
 				};
 
+				i2c1 {
+					pinctrl_i2c1_2: i2c1grp-2 {
+						fsl,pins = <
+							MX6DL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
+							MX6DL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+						>;
+					};
+				};
+
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d79455d..734cb4c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -190,6 +190,13 @@
 							MX6Q_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
 						>;
 					};
+
+					pinctrl_i2c1_2: i2c1grp-2 {
+						fsl,pins = <
+							MX6Q_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
+							MX6Q_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+						>;
+					};
 				};
 
 				i2c2 {
-- 
1.7.1
