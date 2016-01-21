From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 21 Jan 2016 13:26:36 +0800
Subject: [PATCH RFC 09/15] ARM: dts: sun6i: sina31s: Switch to mmc3 for
 onboard eMMC
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Message-ID: <1453354002-28366-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Allwinner, only mmc3 supports 8 bit DDR transfers for eMMC.
Switch to mmc3 for the onboard eMMC, and also assign vqmmc for signal
voltage sensing/switching, and "cap-mmc-hw-reset" to denote this
instance can use eMMC hardware reset.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
index ea69fb8ad4d8..4ec0c8679b2e 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
@@ -61,12 +61,14 @@
 };
 
 /* eMMC on core board */
-&mmc2 {
+&mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
+	pinctrl-0 = <&mmc3_8bit_emmc_pins>;
 	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
+	cap-mmc-hw-reset;
 	status = "okay";
 };
 
-- 
2.7.0.rc3
