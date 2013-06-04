From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 04 Jun 2013 09:15:07 +0200
Subject: [PATCHv4 3/3] Add DT bindings documentation for g762 driver
In-Reply-To: <cover.1340327864.git.arno@natisbad.org>
References: <cover.1340327864.git.arno@natisbad.org>
Message-ID: <0162ace15ab54e9b585af0f91588552fbd39ad39.1370327864.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 Documentation/devicetree/bindings/hwmon/g762.txt |   41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt

diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
new file mode 100644
index 0000000..574524d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/g762.txt
@@ -0,0 +1,41 @@
+GMT G762/G763 PWM Fan controller
+
+Required node properties:
+
+ - "compatible": must be either "gmt,g762" or "gmt,g763"
+ - "reg": I2C bus address of the device
+
+Optional properties:
+
+ - "pwm_freq": reference clock frequency for PWM mode in Hz. If not set,
+               default value is 32768.
+
+ - "fan_pulses": number of pulses per fan revolution. Supported values
+               are 2 and 4.
+
+ - "fan_startv": fan startup voltage. Accepted values are 0, 1, 2 and 3.
+               The higher the more.
+
+ - "pwm_polarity": pwm polarity. Accepted values are 0 (positive duty)
+               and 1 (negative duty).
+
+ - "fan_gear_mode": fan gear mode. Supported values are 0, 1 and 2.
+
+If an optional property is not set in .dts file, then current value is kept
+unmodified (e.g. u-boot installed value).
+
+Additional information on operational parameters for the device is available
+in Documentation/hwmon/g762. A detailed datasheet for the device is available
+at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
+
+Example g762 node:
+
+   g762: g762 at 3e {
+	compatible = "gmt,g762";
+	reg = <0x3e>;
+	pwm_freq = <8192>;   /* PWM reference clock freq */
+	fan_pulses = <2>;    /* 2 pulses per rev */
+	fan_gear_mode = <0>; /* chip default */
+	fan_startv = <1>;    /* chip default */
+	pwm_polarity = <0>;  /* chip default */
+   };
-- 
1.7.10.4
