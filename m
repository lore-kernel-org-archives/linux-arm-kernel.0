From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Dec 2015 14:29:02 +0100
Subject: [PATCH] ARM: mvebu: remove duplicated regulator definition in Armada
 388 GP
Message-ID: <1449235742-5785-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 388 GP Device Tree file describes two times a regulator
named 'reg_usb2_1_vbus', with the exact same description. This has
been wrong since Armada 388 GP support was introduced.

Fixes: 928413bd859c0 ("ARM: mvebu: Add Armada 388 General Purpose Development Board support")
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v4.0+
---
 arch/arm/boot/dts/armada-388-gp.dts | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index a633be3..cd31602 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -303,16 +303,6 @@
 		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
 	};
 
-	reg_usb2_1_vbus: v5-vbus1 {
-		compatible = "regulator-fixed";
-		regulator-name = "v5.0-vbus1";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		regulator-always-on;
-		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
-	};
-
 	reg_sata0: pwr-sata0 {
 		compatible = "regulator-fixed";
 		regulator-name = "pwr_en_sata0";
-- 
2.6.3
