From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 10 Sep 2014 20:46:55 +0200
Subject: [PATCH 6/6] ARM: dts: rockchip: clean up rk3xxx mmc nodes
In-Reply-To: <1410374815-20208-1-git-send-email-heiko@sntech.de>
References: <1410374815-20208-1-git-send-email-heiko@sntech.de>
Message-ID: <1410374815-20208-7-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 356649ab6d64 ("ARM: dts: rockchip: unuse the slot-node and deprecate
the supports-highspeed for dw-mmc") removed the slots but not the #xx-cells
properties describing the subnodes. Do this now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index c383f5c..9945bb9 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -118,8 +118,6 @@
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x10214000 0x1000>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
 		clock-names = "biu", "ciu";
@@ -131,8 +129,6 @@
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x10218000 0x1000>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
 		clock-names = "biu", "ciu";
-- 
2.0.1
