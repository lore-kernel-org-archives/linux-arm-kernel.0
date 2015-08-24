From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Mon, 24 Aug 2015 11:40:04 +0200
Subject: [PATCH 1/1] ARM: DT: STi: STiH418: Fix mmc0 clock configuration
Message-ID: <1440409204-11108-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configure correctly the MMC-0 clock for STiH418 platform.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih418-b2199.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 82eee39..7a03ca6 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -85,6 +85,10 @@
 			sd-uhs-sdr50;
 			sd-uhs-sdr104;
 			sd-uhs-ddr50;
+
+			assigned-clocks = <&clk_s_c0_flexgen CLK_MMC_0>;
+			assigned-clock-parents = <&clk_s_c0_pll1 0>;
+			assigned-clock-rates = <200000000>;
 		};
 
 		miphy28lp_phy: miphy28lp at 9b22000 {
-- 
1.9.1
