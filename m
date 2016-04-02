From: guodong.xu@linaro.org (Guodong Xu)
Date: Sat,  2 Apr 2016 17:29:42 +0800
Subject: [PATCH v2 15/16] arm64: dts: add dwmmc nodes for hi6220
In-Reply-To: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
References: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1459589383-16914-16-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xinwei Kong <kong.kongxinwei@hisilicon.com>

Add all three dwmmc nodes description for hi6220

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 6afd327..28bd441 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -738,5 +738,58 @@
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			#mbox-cells = <3>;
 		};
+
+		dwmmc_0: dwmmc0 at f723d000 {
+			compatible = "hisilicon,hi6220-dw-mshc";
+			num-slots = <0x1>;
+			cap-mmc-highspeed;
+			non-removable;
+			reg = <0x0 0xf723d000 0x0 0x1000>;
+			interrupts = <0x0 0x48 0x4>;
+			clocks = <&sys_ctrl 2>, <&sys_ctrl 1>;
+			clock-names = "ciu", "biu";
+			bus-width = <0x8>;
+			vmmc-supply = <&ldo19>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&emmc_pmx_func &emmc_clk_cfg_func
+				     &emmc_cfg_func &emmc_rst_cfg_func>;
+		};
+
+		dwmmc_1: dwmmc1 at f723e000 {
+			compatible = "hisilicon,hi6220-dw-mshc";
+			num-slots = <0x1>;
+			card-detect-delay = <200>;
+			hisilicon,peripheral-syscon = <&ao_ctrl>;
+			cap-sd-highspeed;
+			reg = <0x0 0xf723e000 0x0 0x1000>;
+			interrupts = <0x0 0x49 0x4>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			clocks = <&sys_ctrl 4>, <&sys_ctrl 3>;
+			clock-names = "ciu", "biu";
+			vqmmc-supply = <&ldo7>;
+			vmmc-supply = <&ldo10>;
+			bus-width = <0x4>;
+			disable-wp;
+			cd-gpios = <&gpio1 0 1>;
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&sd_pmx_func &sd_clk_cfg_func &sd_cfg_func>;
+			pinctrl-1 = <&sd_pmx_idle &sd_clk_cfg_idle &sd_cfg_idle>;
+		};
+
+		dwmmc_2: dwmmc2 at f723f000 {
+			compatible = "hisilicon,hi6220-dw-mshc";
+			status = "okay";
+			num-slots = <0x1>;
+			reg = <0x0 0xf723f000 0x0 0x1000>;
+			interrupts = <0x0 0x4a 0x4>;
+			clocks = <&sys_ctrl HI6220_MMC2_CIUCLK>, <&sys_ctrl HI6220_MMC2_CLK>;
+			clock-names = "ciu", "biu";
+			bus-width = <0x4>;
+			broken-cd;
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&sdio_pmx_func &sdio_clk_cfg_func &sdio_cfg_func>;
+			pinctrl-1 = <&sdio_pmx_idle &sdio_clk_cfg_idle &sdio_cfg_idle>;
+		};
 	};
 };
-- 
1.9.1
