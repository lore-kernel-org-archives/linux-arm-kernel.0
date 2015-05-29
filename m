From: eric@anholt.net (Eric Anholt)
Date: Fri, 29 May 2015 12:42:13 -0700
Subject: [PATCH v6 1/3] dt/bindings: Add binding for the Raspberry Pi firmware
 driver
Message-ID: <1432928535-27522-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver will provide support for calls into the firmware that will
be used by other drivers like cpufreq and vc4.

v2: Improve commit message, point to mailbox.txt for how mboxes work.
v3: Use Lee's suggestion for mailbox phandle docs, fix spelling of
    "raspberry".
v4: Change the compatible string to "raspberrypi,bcm2835-firmware"
    (requested by Lee, agreed by Stephen)

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---
 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
new file mode 100644
index 0000000..5fb1868
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
@@ -0,0 +1,14 @@
+Raspberry Pi VideoCore firmware driver
+
+Required properties:
+
+- compatible:		Should be "rasbperrypi,bcm2835-firmware"
+- mboxes:		Phandle to the firmware device's Mailbox.
+			  (See: ../mailbox/mailbox.txt for more information)
+
+Example:
+
+firmware {
+	compatible = "raspberrypi,bcm2835-firmware";
+	mboxes = <&mailbox>;
+};
-- 
2.1.4
