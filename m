From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 29 Jun 2016 20:47:02 +0200
Subject: [PATCH 4/4] ARM: dts: sun5i: Add mmc1 / sdio-wifi node to mk802
In-Reply-To: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
References: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467226022-10525-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The a10s mk802 uses a rtl8189es sdio wifi chip, add a node enabling
the mmc1 controller, this enables using the wifi chip (together with
an out of tree sdio driver for it).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-mk802.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
index 04120e1..c84ac00 100644
--- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -97,6 +97,15 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.7.4
