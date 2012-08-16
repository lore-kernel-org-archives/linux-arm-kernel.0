From: jason77.wang@gmail.com (Hui Wang)
Date: Thu, 16 Aug 2012 18:47:30 +0800
Subject: [PATCH v4 2/3] Input: add devicetree binding note for egalax_ts
In-Reply-To: <1345114051-3052-2-git-send-email-jason77.wang@gmail.com>
References: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <1345114051-3052-3-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The egalax_ts driver needs to get the gpio number of the irq pin,
and use this gpio to wake up the controller. So add a note
for this change.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 .../bindings/input/touchscreen/egalax-ts.txt       |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
new file mode 100644
index 0000000..df70318
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
@@ -0,0 +1,19 @@
+* EETI eGalax Multiple Touch Controller
+
+Required properties:
+- compatible: must be "eeti,egalax_ts"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: touch controller interrupt
+- wakeup-gpios: the gpio pin to be used for waking up the controller
+  as well as uased as irq pin
+
+Example:
+
+	egalax_ts at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 2>;
+		wakeup-gpios = <&gpio1 9 0>;
+	};
-- 
1.7.6
