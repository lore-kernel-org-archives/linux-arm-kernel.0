From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri,  7 Oct 2016 10:25:54 +0200
Subject: [PATCH v4 07/10] ARM: dts: sun8i: Enable sun8i-emac on the Orange PI
 One
In-Reply-To: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1475828757-926-8-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans de Goede <hdegoede@redhat.com>

The sun8i-emac hardware is present on the Orange PI One.
It uses the internal PHY.

This patch create the needed emac node.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 0adf932..25f2455 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -54,6 +54,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &emac;
 	};
 
 	chosen {
@@ -94,6 +95,13 @@
 	status = "okay";
 };
 
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.7.3
