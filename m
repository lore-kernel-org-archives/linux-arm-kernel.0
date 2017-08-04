From: rocky.hao@rock-chips.com (Rocky Hao)
Date: Fri,  4 Aug 2017 16:06:14 +0800
Subject: [PATCH v2 3/5] arm64: dts: rockchip: add tsadc node for rk3328 SoC
In-Reply-To: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
Message-ID: <1501833976-1100-4-git-send-email-rocky.hao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add tsadc needed main information for rk3328 SoC.
50000Hz is the max clock rate supported by tsadc module.

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
Change in v2:
- remove gerrit Change-Id

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index db4b2708084d..186fb93fdffd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -308,6 +308,26 @@
 		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	tsadc: tsadc at ff250000 {
+		compatible = "rockchip,rk3328-tsadc";
+		reg = <0x0 0xff250000 0x0 0x100>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
+		rockchip,grf = <&grf>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		assigned-clocks = <&cru SCLK_TSADC>;
+		assigned-clock-rates = <50000>;
+		resets = <&cru SRST_TSADC>;
+		reset-names = "tsadc-apb";
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&otp_gpio>;
+		pinctrl-1 = <&otp_out>;
+		pinctrl-2 = <&otp_gpio>;
+		#thermal-sensor-cells = <1>;
+		rockchip,hw-tshut-temp = <100000>;
+		status = "disabled";
+	};
+
 	saradc: adc at ff280000 {
 		compatible = "rockchip,rk3328-saradc", "rockchip,rk3399-saradc";
 		reg = <0x0 0xff280000 0x0 0x100>;
-- 
1.9.1
