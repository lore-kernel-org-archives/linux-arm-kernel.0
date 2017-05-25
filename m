From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 15:31:37 +0800
Subject: [PATCH 5/6] ARM: sun6i: a31: hummingbird: Enable AXP221's ACIN power
 supply
In-Reply-To: <20170525073138.20907-1-wens@csie.org>
References: <20170525073138.20907-1-wens@csie.org>
Message-ID: <20170525073138.20907-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACIN pins of the AXP221 PMIC on the A31 Hummingbird are tied to the
DC jack on the board through a 12V to 5V buck converter.

Enable the ACIN power supply.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 55607208468b..9ecb5f0b3f83 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -253,6 +253,10 @@
 
 #include "axp22x.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
-- 
2.11.0
