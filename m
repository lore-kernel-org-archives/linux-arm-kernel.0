From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Jun 2015 14:38:39 +0200
Subject: [PATCH 1/3] ARM: mvebu: fix description of pwr-sata0 regulator on
 Armada 388 GP
In-Reply-To: <1434631121-32014-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434631121-32014-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1434631121-32014-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This regulator was lacking the reference to the GPIO that controls it,
and the regulator-min-microvolt and regulator-max-microvolt
properties. Thanks to this commit, the pwr-sata0 regulator now looks
more like the other pwr-sata{1,2,3} regulators in the same Device
Tree, with of course the exception of a different GPIO reference.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 78514ab..5164b9a 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -301,9 +301,11 @@
 	reg_sata0: pwr-sata0 {
 		compatible = "regulator-fixed";
 		regulator-name = "pwr_en_sata0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
 		enable-active-high;
 		regulator-always-on;
-
+		gpio = <&expander0 2 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_5v_sata0: v5-sata0 {
-- 
2.1.0
