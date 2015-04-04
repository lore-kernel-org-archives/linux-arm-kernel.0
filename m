From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 4 Apr 2015 09:43:37 +0200
Subject: [PATCHv6] media: i2c/adp1653: Documentation for devicetree
 support for adp1653
In-Reply-To: <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
References: <20150402143846.GA11687@amd> <20150402203417.GA6336@amd>
 <20150403083353.GA21070@amd>
 <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
 <20150403202624.GA4308@amd>
 <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
Message-ID: <20150404074337.GA31064@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Documentation for adp1653 binding.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

---

Please apply.

Sorry, wrong version of patch was sent last time.
									Pavel

diff --git a/Documentation/devicetree/bindings/media/i2c/adp1653.txt b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
new file mode 100644
index 0000000..4607ce3
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
@@ -0,0 +1,37 @@
+* Analog Devices ADP1653 flash LED driver
+
+Required Properties:
+
+  - compatible: Must contain be "adi,adp1653"
+
+  - reg: I2C slave address
+
+  - enable-gpios: Reference to the GPIO that controls the power for the chip.
+
+There are two LED outputs available - flash and indicator. One LED is
+represented by one child node, nodes need to be named "flash" and "indicator".
+
+Required properties of the LED child node:
+- max-microamp : see Documentation/devicetree/bindings/leds/common.txt
+
+Required properties of the flash LED child node:
+
+- flash-max-microamp : see Documentation/devicetree/bindings/leds/common.txt
+- flash-timeout-us : see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+
+	adp1653: led-controller at 30 {
+		compatible = "adi,adp1653";
+		reg = <0x30>;
+		enable-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
+
+		flash {
+			flash-timeout-us = <500000>;
+			flash-max-microamp = <320000>;
+			max-microamp = <50000>;
+		};
+		indicator {
+			max-microamp = <17500>;
+		};
+	};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
