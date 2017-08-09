From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed,  9 Aug 2017 21:55:54 +0900
Subject: [PATCH] ARM: dts: uniphier: add audio out pin-mux node
Message-ID: <20170809125554.31083-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier AIO2013 audio system needs I2S and clock signal pins
to connect external codec chip.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 246f35ffb638..c70be5d78bd5 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -44,6 +44,11 @@
  */
 
 &pinctrl {
+	pinctrl_aout: aout_grp {
+		groups = "aout";
+		function = "aout";
+	};
+
 	pinctrl_emmc: emmc_grp {
 		groups = "emmc", "emmc_dat8";
 		function = "emmc";
-- 
2.13.2
