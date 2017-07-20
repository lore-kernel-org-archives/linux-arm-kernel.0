From: andy.yan@rock-chips.com (Andy Yan)
Date: Thu, 20 Jul 2017 18:13:41 +0800
Subject: [PATCH] ARM: dts: enable sdmmc for rockchip rv1108 evb
Message-ID: <1500545621-20746-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sdmmc on rv1108 evaluation board. Also
add pinctrl for sdmmc controller.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm/boot/dts/rv1108-evb.dts | 4 ++++
 arch/arm/boot/dts/rv1108.dtsi    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 58cf4ac..58ee0fb 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -56,6 +56,10 @@
 	};
 };
 
+&sdmmc {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 437098b..0da144c 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -202,6 +202,8 @@
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x30130000 0x4000>;
-- 
2.7.4
