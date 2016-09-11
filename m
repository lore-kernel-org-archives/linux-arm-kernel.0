From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 Sep 2016 20:23:23 +0200
Subject: [PATCH 1/5] ARM: dts: sun8i: Add touchscreen node for sun8i-a23-gt90h
In-Reply-To: <20160911182327.824-1-hdegoede@redhat.com>
References: <20160911182327.824-1-hdegoede@redhat.com>
Message-ID: <20160911182327.824-2-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gt90h tablet has a gsl3675 touchscreen, add a dt node describing it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
index f27ebbb..e3c7a25 100644
--- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
+++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
@@ -53,6 +53,15 @@
 	status = "okay";
 };
 
+&touchscreen {
+	reg = <0x40>;
+	compatible = "silead,gsl3675";
+	firmware-name = "gsl3675-gt90h.fw";
+	touchscreen-size-x = <1792>;
+	touchscreen-size-y = <1024>;
+	status = "okay";
+};
+
 &lradc {
 	button at 600 {
 		label = "Back";
-- 
2.9.3
