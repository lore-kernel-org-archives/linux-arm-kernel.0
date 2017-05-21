From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 21 May 2017 18:44:38 +0200
Subject: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero: Enable OTG mode
In-Reply-To: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
References: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1495385079-3697-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 635c21068cf ("usb: dwc2: gadget: Fix WARN_ON messages
during FIFO init") the dwc2 driver is able to handle OTG and gadget
mode for bcm2835. So enable this feature for the Raspberry Pi Zero.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-zero.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
index cc8b832..79a20d5 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -12,7 +12,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
-#include "bcm283x-rpi-usb-host.dtsi"
+#include "bcm283x-rpi-usb-otg.dtsi"
 
 / {
 	compatible = "raspberrypi,model-zero", "brcm,bcm2835";
-- 
2.7.4
