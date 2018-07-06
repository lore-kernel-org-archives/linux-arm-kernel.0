From: huibin.hong@rock-chips.com (Huibin Hong)
Date: Fri,  6 Jul 2018 16:03:57 +0800
Subject: [PATCH] arm64: dts: rockchip: corrected uart1 clock-names for rk3328
Message-ID: <1530864237-14891-1-git-send-email-huibin.hong@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Corrected the uart clock-names or the uart driver might fail.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 2f38ff2..3f5a294 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -297,7 +297,7 @@
 		reg = <0x0 0xff120000 0x0 0x100>;
 		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
-		clock-names = "sclk_uart", "pclk_uart";
+		clock-names = "baudclk", "apb_pclk";
 		dmas = <&dmac 4>, <&dmac 5>;
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
-- 
1.9.1
