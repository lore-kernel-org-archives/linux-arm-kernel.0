From: john@metanate.com (John Keeping)
Date: Tue, 23 Feb 2016 13:40:59 +0000
Subject: [PATCH 1/2] ARM: dts: rockchip: fix MIPI interrupt on rk3288
In-Reply-To: <1456234860-18832-1-git-send-email-john@metanate.com>
References: <1456234860-18832-1-git-send-email-john@metanate.com>
Message-ID: <1456234860-18832-2-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This isn't currently used by the driver but the correct value is 19
since DSIHOST0 is 51 in the TRM and the GIC offset requires 32 to be
subtracted.

Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index c75914b..5597105 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -857,7 +857,7 @@
 	mipi_dsi: mipi at ff960000 {
 		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0xff960000 0x4000>;
-		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_MIPI_DSI0>;
 		clock-names = "ref", "pclk";
 		rockchip,grf = <&grf>;
-- 
2.7.0.226.gfe986fe
