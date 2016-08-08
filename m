From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  8 Aug 2016 21:43:15 +0200
Subject: [PATCH 5/8] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-inet86dz
In-Reply-To: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1470685398-14568-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inet86dz tablet has a gsl1680 touchscreen,
add a dt node describing it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-inet86dz.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-inet86dz.dts b/arch/arm/boot/dts/sun8i-a23-inet86dz.dts
index 0f9f71b..9972021 100644
--- a/arch/arm/boot/dts/sun8i-a23-inet86dz.dts
+++ b/arch/arm/boot/dts/sun8i-a23-inet86dz.dts
@@ -53,6 +53,13 @@
 	status = "okay";
 };
 
+&gsl1680 {
+	touchscreen-size-x = <960>;
+	touchscreen-size-y = <640>;
+	touchscreen-fw-name = "silead/gsl1680-inet86dz.fw";
+	status = "okay";
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_dldo1>;
 };
-- 
2.7.4
