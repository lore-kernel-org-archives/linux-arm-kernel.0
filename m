From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 21 Sep 2016 08:23:42 +0000
Subject: [PATCH V7 1/6] dt: bindings: add thermal device driver for bcm2835
In-Reply-To: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1474446227-1147-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add dt-binding documentation for bcm2835 SOC thermal sensor.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Acked-by: Eric Anholt <eric@anholt.net>
Acked-by: Rob Herring <robh@kernel.org>

Changelog:
 V1 -> V2: renamed file to follow naming conventions
 V2 -> V3: removed 0x in node name

---
 .../bindings/thermal/brcm,bcm2835-thermal.txt           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
new file mode 100644
index 0000000..474531d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
@@ -0,0 +1,17 @@
+Binding for Thermal Sensor driver for BCM2835 SoCs.
+
+Required parameters:
+-------------------
+
+compatible: 	should be one of: "brcm,bcm2835-thermal",
+		"brcm,bcm2836-thermal" or "brcm,bcm2837-thermal"
+reg:		Address range of the thermal registers.
+clocks: 	Phandle of the clock used by the thermal sensor.
+
+Example:
+
+thermal: thermal at 7e212000 {
+	compatible = "brcm,bcm2835-thermal";
+	reg = <0x7e212000 0x8>;
+	clocks = <&clocks BCM2835_CLOCK_TSENS>;
+};
-- 
2.1.4
