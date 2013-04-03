From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  3 Apr 2013 00:18:50 -0600
Subject: [PATCH 1/2] ARM: bcm2835: add dumb framebuffer to device tree
Message-ID: <1364969931-6574-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place a template dumb-framebuffer device into the RPi device tree. The
bootloader is expected to fill in all the parameters at boot time.
Hence, disable the device by default, so if the bootloader doesn't do
this, the device isn't activated with invalid parameters.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835-rpi-b.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 71ea7f9..26106aa 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -8,6 +8,17 @@
 	memory {
 		reg = <0 0x10000000>;
 	};
+
+	framebuffer {
+		compatible = "dumb-framebuffer";
+		status = "disabled";
+		/* The bootloader is expected to fill these in */
+		reg = <0 0>;
+		width = <0>;
+		height = <0>;
+		stride = <0>;
+		format = "";
+	};
 };
 
 &gpio {
-- 
1.7.10.4
