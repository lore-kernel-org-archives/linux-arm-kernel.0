From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 21 Aug 2016 15:10:00 +0000
Subject: [PATCH V3 2/5] ARM: dts: bcm283x: Add dtsi for USB host mode
In-Reply-To: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1471792204-21908-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case dr_mode isn't passed via DT, the dwc2 defaults to OTG mode.
But all Raspberry Pi boards here are designed only for host mode.
So fix this issue by providing a dtsi file which set the dr_mode
to host.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts    |    1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts         |    1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts    |    1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts    |    1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts         |    1 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts       |    1 +
 arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi |    3 +++
 7 files changed, 9 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 35ff4e7..f7f9db3 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
 
 / {
 	compatible = "raspberrypi,model-a-plus", "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 306a84e..8be102f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
 
 / {
 	compatible = "raspberrypi,model-a", "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index d5fdb8e..35cde65 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -2,6 +2,7 @@
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 #include "bcm283x-rpi-smsc9514.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
 
 / {
 	compatible = "raspberrypi,model-b-plus", "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index bfc4bd9..84df85e 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -2,6 +2,7 @@
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 #include "bcm283x-rpi-smsc9512.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
 
 / {
 	compatible = "raspberrypi,model-b-rev2", "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 0371bb7..8e626a8 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -2,6 +2,7 @@
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 #include "bcm283x-rpi-smsc9512.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
 
 / {
 	compatible = "raspberrypi,model-b", "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 29e1cfe..39dccf6 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -2,6 +2,7 @@
 #include "bcm2836.dtsi"
 #include "bcm2835-rpi.dtsi"
 #include "bcm283x-rpi-smsc9514.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
 
 / {
 	compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
diff --git a/arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi b/arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi
new file mode 100644
index 0000000..73f4ece
--- /dev/null
+++ b/arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi
@@ -0,0 +1,3 @@
+&usb {
+	dr_mode = "host";
+};
-- 
1.7.9.5
