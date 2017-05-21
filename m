From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 21 May 2017 18:44:36 +0200
Subject: [PATCH 1/4] ARM: dts: bcm283x: Add dtsi for OTG mode
In-Reply-To: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
References: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1495385079-3697-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi Zero also supports OTG mode. So provide a dtsi file
to configure the USB interface accordingly. The fifo sizes are optimized
for device endpoint 6 and 7 with the maximum of 768.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi

diff --git a/arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi b/arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi
new file mode 100644
index 0000000..e7d217c
--- /dev/null
+++ b/arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi
@@ -0,0 +1,10 @@
+&usb {
+	dr_mode = "otg";
+	g-rx-fifo-size = <256>;
+	g-np-tx-fifo-size = <32>;
+	/*
+	 * According to dwc2 the sum of all device EP
+	 * fifo sizes shouldn't exceed 3776 bytes.
+	 */
+	g-tx-fifo-size = <256 256 512 512 512 768 768>;
+};
-- 
2.7.4
