From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 14 Mar 2016 17:32:24 +0100
Subject: [PATCH 2/3] ARM: dts: sun8i: Fix regulator for mmc0 for
 sun8i-a23-gt90h-v4
In-Reply-To: <1457973145-26203-1-git-send-email-hdegoede@redhat.com>
References: <1457973145-26203-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1457973145-26203-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Address the FIXME comment in sun8i-a23-gt90h-v4.dts now that we've
proper regulator support.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
index db3c859..d05406c 100644
--- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
+++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
@@ -133,8 +133,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_gt90h>;
-	/* FIXME this really is aldo1, correct once we've pmic support */
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_aldo1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
 	cd-inverted;
-- 
2.7.2
