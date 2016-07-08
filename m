From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:54 +0200
Subject: [PATCH 13/15] ARM: dts: sun8i: Add dt node for rtl8703as wifi chip on
 ga10h
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-14-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ga10h tablet has a rtl8703as wifi chip, add a dt node describing it.

This enables usage of wifi on this tablet (together with the out of
tree rtl8732bs driver).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
index 6566032..de6269d 100644
--- a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
@@ -47,6 +47,11 @@
 / {
 	model = "Allwinner GA10H Quad Core Tablet (v1.1)";
 	compatible = "allwinner,ga10h-v1.1", "allwinner,sun8i-a33";
+
+	aliases {
+		/* Make u-boot set mac-address for rtl8703as (no eeprom) */
+		ethernet0 = &rtl8703as;
+	};
 };
 
 &ehci0 {
@@ -62,6 +67,19 @@
 	};
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>;
+	vmmc-supply = <&reg_dldo1>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	rtl8703as: sdio_wifi at 1 {
+		reg = <1>;
+	};
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.7.4
