From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Sun, 28 May 2017 13:30:26 +0300
Subject: [PATCH v3 1/1] ARM: dts: orange-pi-zero: add node for SPI NOR
In-Reply-To: <20170528103026.6396-1-geomatsi@gmail.com>
References: <20170528103026.6396-1-geomatsi@gmail.com>
Message-ID: <20170528103026.6396-2-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for SPI NOR flash on orange-pi-zero board. Disable this node
by default and leave it to users to enable it if their board has
SPI NOR flash chip populated.

SPI NOR flash was optional in the first production batch in Dec 2016.
In later batches flash chip was pre-populated. However there should
be quite a few boards around which do not have flash chip.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 9e8b082c134f..0b8b969f7c64 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -143,6 +143,19 @@
 	status = "okay";
 };
 
+&spi0 {
+	/* Disable SPI NOR by default: it optional on Orange Pi Zero boards */
+	status = "disabled";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.11.0
