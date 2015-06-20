From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 20 Jun 2015 17:40:07 +0200
Subject: [PATCH 1/4] ARM: dts: sunxi: Add regulator-boot-on to usb host port
 regulator nodes
In-Reply-To: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
References: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1434814810-26285-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

u-boot will have turned on the power to the usb host ports, so mark them
as regulator-boot-on, this stops the power on the ports from temporarily
getting turned off during boot, causing issues with e.g. usb powered
harddisks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index 51cc838..f1953b0 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -108,6 +108,7 @@
 		regulator-name = "usb1-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
 		enable-active-high;
 		gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
@@ -120,6 +121,7 @@
 		regulator-name = "usb2-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
 		enable-active-high;
 		gpio = <&pio 7 3 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
-- 
2.4.3
