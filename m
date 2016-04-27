From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 27 Apr 2016 09:05:03 +0200
Subject: [PATCH] ARM: BCM5301X: Enable SPI-NOR on dual flash devices
Message-ID: <1461740704-21501-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1b47b98acce2 ("ARM: BCM5301X: Add DT entry for SPI controller and
NOR flash") enabled SPI-NOR device on routers using serial flash only.
However there are also devices with two flash memories:
1) Small SPI attached flash used mostly for booting
2) Bigger NAND used mostly for storing firmware
On such devices we still need SPI-NOR e.g. to access NVRAM data.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts | 4 ++++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts       | 4 ++++
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts    | 4 ++++
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts | 4 ++++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts     | 4 ++++
 5 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index 5087aa8..9cb186e 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -147,3 +147,7 @@
 &usb3 {
 	vcc-gpio = <&chipcommon 10 GPIO_ACTIVE_LOW>;
 };
+
+&spi_nor {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 1049ab1..8ce39d5 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -90,3 +90,7 @@
 &usb3 {
 	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
 };
+
+&spi_nor {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
index 3a94606..6229ef2 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -82,3 +82,7 @@
 		};
 	};
 };
+
+&spi_nor {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index 791d722..0653e7e 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -131,3 +131,7 @@
 &usb2 {
 	vcc-gpio = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
 };
+
+&spi_nor {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index ace38ef..50cf804 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -113,3 +113,7 @@
 &usb3 {
 	vcc-gpio = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
 };
+
+&spi_nor {
+	status = "okay";
+};
-- 
1.8.4.5
