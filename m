From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Mar 2013 19:55:00 +0100
Subject: PCI support for IMX6
Message-ID: <20130329185500.GB30029@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

What is the state of PCI support for IMX6? I have board that has
e1000e connected via PCI, and I'd like to get network to work.

I'm currently trying to port PCI support from 3.0, but it does not
look exactly easy.

Is there experimental tree somewhere I could try?

So far I have this small patch and working serial. (Would it make
sense to try merging it now?)

---

Basic support for sbc6x board. Serial works.

Signed-off-by: Pavel Machek <pavel@denx.de>
							Pavel

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..1590ae9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -99,7 +99,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-arm2.dtb \
 	imx6q-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
-	imx6q-sabresd.dtb
+	imx6q-sabresd.dtb \
+	imx6q-sbc6x.dtb
 dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx23-olinuxino.dtb \
 	imx23-stmp378x_devb.dtb \
diff --git a/arch/arm/boot/dts/imx6q-sbc6x.dts b/arch/arm/boot/dts/imx6q-sbc6x.dts
new file mode 100644
index 0000000..9549b6f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sbc6x.dts
@@ -0,0 +1,26 @@
+/*
+ * Copyright 2013 Pavel Machek <pavel@denx.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License V2.
+ */
+
+/dts-v1/;
+/include/ "imx6q.dtsi"
+
+/ {
+	model = "MicroSys sbc6x board";
+	compatible = "fsl,imx6q";
+
+	memory {
+		reg = <0x10000000 0x80000000>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
+
+

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
