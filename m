From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Aug 2016 13:17:37 +0100
Subject: [PATCH 4/7] ARM: dts: STiH407: Move non-removable property to board
 file
In-Reply-To: <20160815121740.29515-1-lee.jones@linaro.org>
References: <20160815121740.29515-1-lee.jones@linaro.org>
Message-ID: <20160815121740.29515-5-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Due to 96board which uses mmc0 node for SD card, the non-removable
property must be moved from STiH407-family to board file for B2120
and B2199 boards.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 1 -
 arch/arm/boot/dts/stih418-b2199.dts   | 1 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi  | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index d294e824..59fea05 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -553,7 +553,6 @@
 			clock-names = "mmc";
 			clocks = <&clk_s_c0_flexgen CLK_MMC_0>;
 			bus-width = <8>;
-			non-removable;
 		};
 
 		mmc1: sdhci at 09080000 {
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 772d2bb..7c45e75 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -86,6 +86,7 @@
 			sd-uhs-sdr50;
 			sd-uhs-sdr104;
 			sd-uhs-ddr50;
+			non-removable;
 		};
 
 		miphy28lp_phy: miphy28lp at 9b22000 {
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 133375b..0b0dd02 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -65,6 +65,7 @@
 		};
 
 		mmc0: sdhci at 09060000 {
+			non-removable;
 			status = "okay";
 		};
 
-- 
2.9.0
