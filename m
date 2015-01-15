From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jan 2015 18:23:17 +0100
Subject: [PATCH v4 1/5] rtc: armada38x: Add the device tree binding
 documentation
In-Reply-To: <1421342601-20384-1-git-send-email-gregory.clement@free-electrons.com>
References: <1421342601-20384-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1421342601-20384-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 38x SoCs come with a new RTC which differs from the one
used in the other mvebu SoCs until now. This patch describes the
binding of this RTC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/rtc/armada-380-rtc.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/armada-380-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
new file mode 100644
index 000000000000..2eb9d4ee7dc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
@@ -0,0 +1,22 @@
+* Real Time Clock of the Armada 38x SoCs
+
+RTC controller for the Armada 38x SoCs
+
+Required properties:
+- compatible : Should be "marvell,armada-380-rtc"
+- reg: a list of base address and size pairs, one for each entry in
+  reg-names
+- reg names: should contain:
+  * "rtc" for the RTC registers
+  * "rtc-soc" for the SoC related registers and among them the one
+    related to the interrupt.
+- interrupts: IRQ line for the RTC.
+
+Example:
+
+rtc at a3800 {
+	compatible = "marvell,armada-380-rtc";
+	reg = <0xa3800 0x20>, <0x184a0 0x0c>;
+	reg-names = "rtc", "rtc-soc";
+	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
1.9.1
