From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:43 +0800
Subject: [PATCH v4 07/16] arm64: dts: add all hi6220 i2c nodes
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-8-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xinwei Kong <kong.kongxinwei@hisilicon.com>

This patch adds all I2C nodes for the Hi6220 SoC. This hi6220 Soc
use this I2C IP of Synopsys Designware for HiKey board.

Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 7bcfffe..4fc0347 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -582,5 +582,38 @@
 			cs-gpios = <&gpio6 2 0>;
 			status = "disabled";
 		};
+
+		i2c0: i2c at f7100000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xf7100000 0x0 0x1000>;
+			interrupts = <0 44 4>;
+			clocks = <&sys_ctrl HI6220_I2C0_CLK>;
+			i2c-sda-hold-time-ns = <300>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at f7101000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xf7101000 0x0 0x1000>;
+			clocks = <&sys_ctrl HI6220_I2C1_CLK>;
+			interrupts = <0 45 4>;
+			i2c-sda-hold-time-ns = <300>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at f7102000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xf7102000 0x0 0x1000>;
+			clocks = <&sys_ctrl HI6220_I2C2_CLK>;
+			interrupts = <0 46 4>;
+			i2c-sda-hold-time-ns = <300>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
