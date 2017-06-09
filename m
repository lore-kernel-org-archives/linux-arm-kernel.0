From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Jun 2017 00:05:49 +0800
Subject: [PATCH] ARM: sun6i: a31s: primo81: Enable battery power supply
In-Reply-To: <20170609160549.3566-1-wens@csie.org>
References: <20170609160549.3566-1-wens@csie.org>
Message-ID: <20170609160549.3566-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSI Primo81 tablet has a 3500 mAh 3.7V LiPo battery.

Enable the PMIC's battery power supply so the battery can be monitored.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-primo81.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 73b163a7d9dd..4c10123509c4 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -164,6 +164,10 @@
 
 #include "axp22x.dtsi"
 
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo3 {
 	regulator-always-on;
 	regulator-min-microvolt = <2700000>;
-- 
2.11.0
