From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 22 Jul 2017 22:45:48 +0200
Subject: [PATCH] ARM: dts: rockchip: fix property-ordering in rv1108 mmc nodes
Message-ID: <20170722204548.19741-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Somehow the strange property ordering of the rv1108 mmc nodes slipped
through when it was added. To lessen the confusion in the future, do
the needed reordering to bring them in line with our regular order.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rv1108.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 21f4f8f6e3ac..4c2133695a55 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -174,39 +174,39 @@
 
 	emmc: dwmmc at 30110000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
-		max-frequency = <150000000>;
+		reg = <0x30110000 0x4000>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x30110000 0x4000>;
+		max-frequency = <150000000>;
 		status = "disabled";
 	};
 
 	sdio: dwmmc at 30120000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
-		max-frequency = <150000000>;
+		reg = <0x30120000 0x4000>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x30120000 0x4000>;
+		max-frequency = <150000000>;
 		status = "disabled";
 	};
 
 	sdmmc: dwmmc at 30130000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
-		max-frequency = <100000000>;
+		reg = <0x30130000 0x4000>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
+		max-frequency = <100000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
-		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x30130000 0x4000>;
 		status = "disabled";
 	};
 
-- 
2.11.0
