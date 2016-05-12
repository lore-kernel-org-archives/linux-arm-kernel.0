From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 12 May 2016 14:35:35 +0000
Subject: [PATCH 1/4] dt: bindings: add thermal device driver for bcm2835
In-Reply-To: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463063738-11506-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add documentation for bcm2835 SOC thermal sensor.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 .../devicetree/bindings/thermal/bcm2835-thermal.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt
new file mode 100644
index 0000000..607519a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt
@@ -0,0 +1,16 @@
+Binding for Thermal Sensor driver for BCM2835 SoCs.
+
+Required parameters:
+-------------------
+
+compatible : 	should be: "brcm,bcm2835-thermal"
+reg :		Address range of the thermal registers.
+clocks : 	Phandle of the clock used by the thermal sensor.
+
+Example:
+
+thermal: thermal at 0x7e212000 {
+	compatible = "brcm,bcm2835-thermal";
+	reg = <0x7e212000 0x8>;
+	clocks = <&clocks BCM2835_CLOCK_TSENS>;
+};
-- 
2.1.4
