From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Mon, 24 Aug 2015 16:23:21 +0200
Subject: [PATCH v2] ARM: DT: STi: STiH418: Fix mmc0 clock configuration
Message-ID: <1440426201-23201-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configure correctly the MMC-0 clock for STiH418 platform.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih418.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
index 8160a75..965f881 100644
--- a/arch/arm/boot/dts/stih418.dtsi
+++ b/arch/arm/boot/dts/stih418.dtsi
@@ -99,5 +99,11 @@
 			phys = <&usb2_picophy2>;
 			phy-names = "usb";
 		};
+
+		mmc0: sdhci at 09060000 {
+			assigned-clocks = <&clk_s_c0_flexgen CLK_MMC_0>;
+			assigned-clock-parents = <&clk_s_c0_pll1 0>;
+			assigned-clock-rates = <200000000>;
+		};
 	};
 };
-- 
1.9.1
