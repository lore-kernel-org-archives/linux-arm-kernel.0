From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Jul 2017 11:44:50 +0800
Subject: [PATCH v2 08/10] ARM: dts: sun8i: a83t: Add pingroup for 8-bit eMMC
 on mmc2
In-Reply-To: <20170720034452.15920-1-wens@csie.org>
References: <20170720034452.15920-1-wens@csie.org>
Message-ID: <20170720034452.15920-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc2 can support 8-bit eMMC chips, with a dedicated reset line.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 21ab668abfac..d9b4372dbdf3 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -271,6 +271,15 @@
 				bias-pull-up;
 			};
 
+			mmc2_8bit_emmc_pins: mmc2-8bit-emmc-pins {
+				pins = "PC5", "PC6", "PC8", "PC9",
+				       "PC10", "PC11", "PC12", "PC13",
+				       "PC14", "PC15", "PC16";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			spdif_tx_pin: spdif-tx-pin {
 				pins = "PE18";
 				function = "spdif";
-- 
2.13.2
