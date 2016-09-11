From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 Sep 2016 20:23:26 +0200
Subject: [PATCH 4/5] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-polaroid-mid2809pxe04
In-Reply-To: <20160911182327.824-1-hdegoede@redhat.com>
References: <20160911182327.824-1-hdegoede@redhat.com>
Message-ID: <20160911182327.824-5-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node enabling the gsl3670 touchscreen controller found on
sun8i-a23-polaroid-mid2809pxe04 tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
index c9213ca..9955f85 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
@@ -90,3 +90,12 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&touchscreen {
+	reg = <0x40>;
+	compatible = "silead,gsl3670";
+	firmware-name = "gsl3670-polaroid-mid2809pxe04.fw";
+	touchscreen-size-x = <1660>;
+	touchscreen-size-y = <890>;
+	status = "okay";
+};
-- 
2.9.3
