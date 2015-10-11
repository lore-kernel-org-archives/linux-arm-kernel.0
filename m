From: lkundrak@v3.sk (Lubomir Rintel)
Date: Sun, 11 Oct 2015 21:48:57 +0200
Subject: [PATCH] bcm2835: Add Raspberry Pi thermal sensor to the device tree
Message-ID: <1444592937-16320-1-git-send-email-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driven via the Raspberry Pi VideoCore 4 firmware interface.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: devicetree at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
---
Needs the RPi firmware patchset from branch 'rpi-firmware' of 
https://github.com/anholt/linux

 .../bindings/thermal/raspberrypi,bcm2835-thermal.txt        | 13 +++++++++++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                          |  5 +++++
 2 files changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal.txt
new file mode 100644
index 0000000..f323f35
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal.txt
@@ -0,0 +1,13 @@
+Raspberry Pi Broadcom BCM2835 thermal control
+
+Required properties:
+
+- compatible : should be "raspberrypi,bcm2835-thermal"
+- firmware : the Raspberry Pi firmware node
+
+Example:
+
+thermal {
+	compatible = "raspberrypi,bcm2835-thermal";
+	firmware = <&firmware>;
+};
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index ab5474e..727bbf8 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -20,6 +20,11 @@
 			compatible = "raspberrypi,bcm2835-firmware";
 			mboxes = <&mailbox>;
 		};
+
+		thermal {
+			compatible = "raspberrypi,bcm2835-thermal";
+			firmware = <&firmware>;
+		};
 	};
 };
 
-- 
2.4.3
