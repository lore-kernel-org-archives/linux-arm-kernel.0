From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Wed, 24 May 2017 08:34:49 +0800
Subject: [RESEND PATCH 2/2] arm64: dts: rockchip: add sdmmc/sdio/emmc nodes
 for RK3328 SoCs
In-Reply-To: <1495586089-215607-1-git-send-email-shawn.lin@rock-chips.com>
References: <1495586089-215607-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1495586089-215607-2-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sdmmc, sdio, emmc nodes for Rockchip RK3328 SoCs.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 7e69f1f..3210692 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -372,6 +372,39 @@
 			<32768>;
 	};
 
+	sdmmc: dwmmc at ff500000 {
+		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x0 0xff500000 0x0 0x4000>;
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
+			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	sdio: dwmmc at ff510000 {
+		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x0 0xff510000 0x0 0x4000>;
+		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
+			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	emmc: dwmmc at ff520000 {
+		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x0 0xff520000 0x0 0x4000>;
+		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
+			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	gmac2io: ethernet at ff540000 {
 		compatible = "rockchip,rk3328-gmac";
 		reg = <0x0 0xff540000 0x0 0x10000>;
-- 
1.9.1
