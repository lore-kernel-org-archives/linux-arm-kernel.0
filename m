From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri,  9 Mar 2018 14:32:06 +0100
Subject: [PATCH RFC 1/3] dt-bindings: nvmem: add binding for Raspberry Pi OTP
In-Reply-To: <1520602328-28972-1-git-send-email-stefan.wahren@i2se.com>
References: <1520602328-28972-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1520602328-28972-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the devicetree binding for Raspberry Pi customer OTP
driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../nvmem/raspberrypi,bcm2835-customer-otp.txt     | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt b/Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt
new file mode 100644
index 0000000..3f57744
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt
@@ -0,0 +1,27 @@
+Customer OTP Memory for Raspberry Pi
+
+The VC4 firmware exposes a mailbox interface that allows the ARM core
+to access the customer part of the OTP memory.
+
+The OTP node must be a child node of the Raspberry Pi firmware node.
+
+Required properties :
+- compatible     : Should be "raspberrypi,bcm2835-customer-otp"
+- #address-cells : Should be 1
+- #size-cells    : Should be 1
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
+		firmware = <&firmware>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
-- 
2.7.4
