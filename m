From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  2 May 2014 17:57:25 +0200
Subject: [PATCH v10 11/15] ARM: dts: sun6i: Add new sun6i-a31-m9 dts file for
 Mele M9
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399046249-19472-12-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new sun6i-a31-m9 dts file for the Mele M9 / Mele A1000G Quad. These
HTPCs use the same board in a different case, for more details see:
http://linux-sunxi.org/Mele_M9

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile         |  1 +
 arch/arm/boot/dts/sun6i-a31-m9.dts | 48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun6i-a31-m9.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 377b7c3..ffa3f5e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -344,6 +344,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun5i-a13-olinuxino.dtb \
 	sun5i-a13-olinuxino-micro.dtb \
 	sun6i-a31-colombus.dtb \
+	sun6i-a31-m9.dtb \
 	sun7i-a20-cubieboard2.dtb \
 	sun7i-a20-cubietruck.dtb \
 	sun7i-a20-olinuxino-micro.dtb
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
new file mode 100644
index 0000000..22eacf8
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "sun6i-a31.dtsi"
+
+/ {
+	model = "Mele M9 / A1000G Quad top set box";
+	compatible = "mele,m9", "allwinner,sun6i-a31";
+
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,115200";
+	};
+
+	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
+			bus-width = <4>;
+			cd-gpios = <&pio 7 22 0>; /* PH22 */
+			cd-inverted;
+			status = "okay";
+		};
+
+		pio: pinctrl at 01c20800 {
+			mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH22";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+		};
+
+		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
+			status = "okay";
+		};
+	};
+};
-- 
1.9.0
