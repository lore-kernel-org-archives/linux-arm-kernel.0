From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Dec 2015 15:26:13 +0800
Subject: [PATCH v2 2/3] doc: dt-binding: generic onboard USB HUB
In-Reply-To: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1450077974-22762-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt-binding documentation for generic onboard USB HUB.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 .../devicetree/bindings/usb/generic-onboard-hub.txt  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/generic-onboard-hub.txt

diff --git a/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
new file mode 100644
index 0000000..d19d912
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
@@ -0,0 +1,20 @@
+Generic Onboard USB HUB
+
+Required properties:
+- compatible: should be "generic-onboard-hub"
+
+Optional properties:
+- clocks: the input clock for USB HUB.
+- clock-frequency: the frequency for HUB's clock.
+- reset-gpios: Should specify the GPIO for reset.
+- reset-duration-us: the duration for assert reset signal, the time unit
+  is microsecond.
+
+Example:
+
+	usb_hub1 {
+		compatible = "generic-onboard-hub";
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+		hub-reset-duration-us = <2>;
+	};
-- 
1.9.1
