From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 21 Nov 2018 14:11:40 +0100
Subject: [PATCH 1/5] dt-bindings: nvmem: add binding for Raspberry Pi OTP
In-Reply-To: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
References: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1542805904-6446-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the devicetree binding for Raspberry Pi customer OTP
driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../nvmem/raspberrypi,bcm2835-customer-otp.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt b/Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt
new file mode 100644
index 0000000..041ff17
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt
@@ -0,0 +1,22 @@
+Customer OTP Memory for Raspberry Pi
+
+The VC4 firmware exposes a mailbox interface that allows the ARM core
+to access the customer part of the OTP memory.
+
+The OTP node must be a child node of the Raspberry Pi firmware node.
+
+Required properties :
+- compatible     : Should be "raspberrypi,bcm2835-customer-otp"
+
+See nvmem.txt for more information.
+
+Example:
+
+firmware: firmware-rpi {
+	compatible = "raspberrypi,bcm2835-firmware";
+	mboxes = <&mailbox>;
+
+	customer_otp: otp {
+		compatible = "raspberrypi,bcm2835-customer-otp";
+	};
+};
-- 
2.7.4
