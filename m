From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Dec 2012 11:42:02 +0100
Subject: [PATCH 2/2] rtc: rtc-mv: Add the device tree binding documentation
In-Reply-To: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1355136122-30729-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The support was already written, but the binding documentation was
lacking.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/rtc/orion-rtc.txt          |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/orion-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/orion-rtc.txt b/Documentation/devicetree/bindings/rtc/orion-rtc.txt
new file mode 100644
index 0000000..3bf63ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/orion-rtc.txt
@@ -0,0 +1,18 @@
+* Mvebu Real Time Clock
+
+RTC controller for the Kirkwood, the Dove, the Armada 370 and the
+Armada XP SoCs
+
+Required properties:
+- compatible : Should be "marvell,orion-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: IRQ line for the RTC.
+
+Example:
+
+rtc at 10300 {
+        compatible = "marvell,orion-rtc";
+        reg = <0xd0010300 0x20>;
+        interrupts = <50>;
+};
-- 
1.7.9.5
