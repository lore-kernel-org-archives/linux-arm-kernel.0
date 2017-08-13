From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 13 Aug 2017 13:59:27 +0200
Subject: [PATCH] arm64: dts: rockchip: remove num-slots property from
 rk3399-sapphire
Message-ID: <20170813115927.2239-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adding the rk3399 sapphire som, two more of the recently removed
num-slots properties of dw-mmc nodes slipped in.
Remove them again.

Fixes: 8164a84cca12 ("arm64: dts: rockchip: Add support for rk3399 sapphire SOM")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Already applied, posted for reference.

 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index be92a580732b..6c30bb02210d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -530,7 +530,6 @@
 	max-frequency = <50000000>;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
-	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
 	sd-uhs-sdr104;
@@ -544,7 +543,6 @@
 	clock-frequency = <150000000>;
 	disable-wp;
 	max-frequency = <150000000>;
-	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 	vqmmc-supply = <&vcc_sdio>;
-- 
2.11.0
