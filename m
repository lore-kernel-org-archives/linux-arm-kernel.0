From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  4 Dec 2017 18:38:50 +0100
Subject: [PATCH] arm64: dts: rockchip: fix trailing 0 in rk3328 tsadc
 interrupts
Message-ID: <20171204173850.9976-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Probably due to some copy-paste mistake, the tsadc of rk3328 ended up
with a 0 as 4th element that shouldn't be there, as interrupts on the
rk3328 only have multiples of 3, making dtc complain. So remove it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 41d61840fb99..2426da631938 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -514,7 +514,7 @@
 	tsadc: tsadc at ff250000 {
 		compatible = "rockchip,rk3328-tsadc";
 		reg = <0x0 0xff250000 0x0 0x100>;
-		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		assigned-clocks = <&cru SCLK_TSADC>;
 		assigned-clock-rates = <50000>;
 		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
-- 
2.14.2
