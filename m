From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 8 Apr 2014 14:46:07 +0300
Subject: [PATCH v2 2/2] ARM: dts: keystone: move i2c0 device node from SoC to
 board files
In-Reply-To: <1396957567-14540-1-git-send-email-grygorii.strashko@ti.com>
References: <1396957567-14540-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1396957567-14540-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C devices are not the part of Keystone SoC and have to be
defined in board DTS files.
Hence, move i2c0 EEPROM device node from Keystone SoC to
k2hk, k2e, k2l EVM files as they all have similar EEPROM SoCs
installed.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2e-evm.dts   |    7 +++++++
 arch/arm/boot/dts/k2hk-evm.dts  |    7 +++++++
 arch/arm/boot/dts/k2l-evm.dts   |    7 +++++++
 arch/arm/boot/dts/keystone.dtsi |    5 -----
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/k2e-evm.dts b/arch/arm/boot/dts/k2e-evm.dts
index 74b3b63..d60ce34 100644
--- a/arch/arm/boot/dts/k2e-evm.dts
+++ b/arch/arm/boot/dts/k2e-evm.dts
@@ -58,3 +58,10 @@
 &usb1 {
 	status = "okay";
 };
+
+&i2c0 {
+	dtt at 50 {
+		compatible = "at,24c1024";
+		reg = <0x50>;
+	};
+};
diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index c93d06f..d2aa102 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -138,3 +138,10 @@
 		};
 	};
 };
+
+&i2c0 {
+	dtt at 50 {
+		compatible = "at,24c1024";
+		reg = <0x50>;
+	};
+};
diff --git a/arch/arm/boot/dts/k2l-evm.dts b/arch/arm/boot/dts/k2l-evm.dts
index 50a7013..bdc94a0 100644
--- a/arch/arm/boot/dts/k2l-evm.dts
+++ b/arch/arm/boot/dts/k2l-evm.dts
@@ -35,3 +35,10 @@
 &usb {
 	status = "okay";
 };
+
+&i2c0 {
+	dtt at 50 {
+		compatible = "at,24c1024";
+		reg = <0x50>;
+	};
+};
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index f730392..7563934 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -102,11 +102,6 @@
 			interrupts = <GIC_SPI 283 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-
-			dtt at 50 {
-				compatible = "at,24c1024";
-				reg = <0x50>;
-			};
 		};
 
 		i2c1: i2c at 2530400 {
-- 
1.7.9.5
