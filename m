From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 26 Aug 2016 16:42:26 +0200
Subject: [PATCH 4/4] ARM: dts: sun8i: Rename reference-design-tablet
 touchscreen node
In-Reply-To: <20160826144226.29969-1-hdegoede@redhat.com>
References: <20160826144226.29969-1-hdegoede@redhat.com>
Message-ID: <20160826144226.29969-4-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the reference-design-tablet touchscreen node from gsl1680 to
touchscreen, all? tablets seem to use the same power and interrupt
gpio-s, but not all tablets use a gsl1680 controller making the
gsl1680 name somewhat misleading.

Also move the reg and compatible property to the actual tablet dts
as they may differ per tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index f29897c..08cd001 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -71,15 +71,13 @@
 	 */
 	clock-frequency = <400000>;
 
-	gsl1680: touchscreen at 40 {
-		compatible = "silead,gsl1680";
-		reg = <0x40>;
+	touchscreen: touchscreen at 0 {
 		interrupt-parent = <&pio>;
 		interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>; /* PB5 */
 		pinctrl-names = "default";
 		pinctrl-0 = <&ts_power_pin>;
 		power-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-		/* Most tablets use this touchscreen, but not all */
+		/* Tablet dts must provide reg and compatible */
 		status = "disabled";
 	};
 };
-- 
2.9.3
