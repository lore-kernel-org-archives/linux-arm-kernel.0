From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Nov 2013 12:49:27 -0200
Subject: mx6qsabresd: Adding eMMC suport
Message-ID: <CAOMZO5DvYQRBWmJwXBA_kDG_rt0rpreLzshx+dY_UEttQMSE-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When I add support to esdhc4 port, which is connected to a eMMC on mx6qsabresd:

--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -229,6 +229,10 @@
                pinctrl_usdhc3: usdhc3grp {
                        fsl,pins = <MX6QDL_USDHC3_PINGRP1>;
                };
+
+               pinctrl_usdhc4: usdhc4grp {
+                       fsl,pins = <MX6QDL_USDHC4_PINGRP1>;
+               };
        };
 };

@@ -304,3 +308,11 @@
        wp-gpios = <&gpio2 1 0>;
        status = "okay";
 };
+
+&usdhc4 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_usdhc4>;
+       bus-width = <8>;
+       non-removable;
+       status = "okay";
+};

I get the following:

mmc2: Timeout waiting for hardware interrupt.
 mmcblk1boot1: unknown partition table
mmc2: Timeout waiting for hardware interrupt.
 mmcblk1boot0: unknown partition table

The boots proceeds until the end, but there is a big delay due to the
above messages.

Does anything special need to be done in order to support eMMC?

Regards,

Fabio Estevam
