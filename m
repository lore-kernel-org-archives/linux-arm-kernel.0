From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  3 Apr 2013 20:40:56 -0600
Subject: [PATCH V2 1/2] ARM: bcm2835: add simple framebuffer to device tree
Message-ID: <1365043257-29296-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place a template simple-framebuffer device into the RPi device tree. The
bootloader is expected to fill in all the parameters at boot time.
Hence, disable the device by default, so if the bootloader doesn't do
this, the device isn't activated with invalid parameters.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
v2: s/dumb/simple/ throughout.
---
 arch/arm/boot/dts/bcm2835-rpi-b.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index aafda17..09e0d40 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -8,6 +8,17 @@
 	memory {
 		reg = <0 0x10000000>;
 	};
+
+	framebuffer {
+		compatible = "simple-framebuffer";
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
