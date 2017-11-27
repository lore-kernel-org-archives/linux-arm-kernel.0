From: stefan@olimex.com (Stefan Mavrodiev)
Date: Mon, 27 Nov 2017 14:03:51 +0200
Subject: [PATCH 1/1] ARM: dts: sunxi: Update dts for A20-OLinuXino boards
Message-ID: <1511784231-6485-1-git-send-email-stefan@olimex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There will be option with 16MB flash for the following boards:

  * A20-OLinuXino-MICRO Rev.K
  * A20-OLinuXino-LIME Rev.J
  * A20-OLinuXino-LIME2 Rev.J
  * A20-SOM-EVB Rev.E

The used flash chip is Winbond W25Q128FV, which is connected to
SPI0 port. Since this is optional feature, spi0 node is dissabled
by default. Also this option is incompatible with NAND flash, so
they shouldn't be enabled at the same time.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts  | 14 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  | 14 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 14 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 14 ++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index 64c8ef9..98b7697 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -291,6 +291,20 @@
 	status = "okay";
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_b>,<&spi0_cs0_pins_b>;
+	status = "disabled";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128","jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 &spi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins_a>,
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index edf9c3c..354af5d 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -218,6 +218,20 @@
 	status = "okay";
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_b>,<&spi0_cs0_pins_b>;
+	status = "disabled";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128","jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ba25018..6fcdd6e 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -268,6 +268,20 @@
 	status = "okay";
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_b>,<&spi0_cs0_pins_b>;
+	status = "disabled";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128","jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index dffbaa2..db85895 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -331,6 +331,20 @@
 	status = "okay";
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_b>,<&spi0_cs0_pins_b>;
+	status = "disabled";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128","jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 &spi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins_a>,
-- 
2.7.4
