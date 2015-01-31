From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Jan 2015 17:33:02 +0100
Subject: [PATCH 09/11] ARM: dts: rockchip: add rk3288 lcdc0 pinmux settings
In-Reply-To: <1422721984-27782-1-git-send-email-heiko@sntech.de>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
Message-ID: <1422721984-27782-10-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl settings for the configurable lcdc0 signals dclk, den, hsync
and vsync. The lcdc0 data pin configuration is not software controlable.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index d771f68..846d961 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -910,6 +910,15 @@
 			};
 		};
 
+		lcdc0 {
+			lcdc0_ctl: lcdc0-ctl {
+				rockchip,pins = <1 24 RK_FUNC_1 &pcfg_pull_none>,
+						<1 25 RK_FUNC_1 &pcfg_pull_none>,
+						<1 26 RK_FUNC_1 &pcfg_pull_none>,
+						<1 27 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		sdmmc {
 			sdmmc_clk: sdmmc-clk {
 				rockchip,pins = <6 20 RK_FUNC_1 &pcfg_pull_none>;
-- 
2.1.1
