From: addy.ke@rock-chips.com (Addy Ke)
Date: Thu,  4 Dec 2014 10:49:35 +0800
Subject: [PATCH] ARM: dts: rockchip: set dw_mmc max-freq 150Mhz
Message-ID: <1417661375-2872-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of mmc controllers include SDMMC, SDIO0, SDIO1, and EMMC on RK3288
are limited to 150Mhz. It was mainly caused by two reasons:
- RK3288's IO pad(except DDR IO pad) is generic, which can only support
  the max of 150Mhz.
- Mmc controller was designed at 150Mhz, and the pressure test by IC team
  was based on this freequency point.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index acb6a2f..9c35a1d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -149,6 +149,7 @@
 
 	sdmmc: dwmmc at ff0c0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
+		clock-freq-min-max = <400000 150000000>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x100>;
@@ -159,6 +160,7 @@
 
 	sdio0: dwmmc at ff0d0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
+		clock-freq-min-max = <400000 150000000>;
 		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x100>;
@@ -169,6 +171,7 @@
 
 	sdio1: dwmmc at ff0e0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
+		clock-freq-min-max = <400000 150000000>;
 		clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x100>;
@@ -179,6 +182,7 @@
 
 	emmc: dwmmc at ff0f0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
+		clock-freq-min-max = <400000 150000000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x100>;
-- 
1.8.3.2
