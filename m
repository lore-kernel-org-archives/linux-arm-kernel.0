From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 Sep 2016 20:23:27 +0200
Subject: [PATCH 5/5] ARM: dts: sun8i: Add touchscreen node for sun8i-a33-ga10h
In-Reply-To: <20160911182327.824-1-hdegoede@redhat.com>
References: <20160911182327.824-1-hdegoede@redhat.com>
Message-ID: <20160911182327.824-6-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ga10h tablet has a gsl3675 touchscreen, add a dt node describing it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
index de6269d..f711599 100644
--- a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
@@ -58,6 +58,16 @@
 	status = "okay";
 };
 
+&touchscreen {
+	reg = <0x40>;
+	compatible = "silead,gsl3675";
+	firmware-name = "gsl3675-ga10h.fw";
+	touchscreen-size-x = <1630>;
+	touchscreen-size-y = <990>;
+	touchscreen-inverted-y;
+	status = "okay";
+};
+
 &lradc {
 	button at 600 {
 		label = "Back";
-- 
2.9.3
