From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 22 Mar 2015 00:29:57 +0000
Subject: [PATCH 1/7] DT: add binding for mxs power subsystem
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1426984203-9133-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree bindings for the Freescale MXS
power subsystem.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/power/mxs_power.txt        |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mxs_power.txt

diff --git a/Documentation/devicetree/bindings/power/mxs_power.txt b/Documentation/devicetree/bindings/power/mxs_power.txt
new file mode 100644
index 0000000..aa9139b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mxs_power.txt
@@ -0,0 +1,23 @@
+Power subsystem for Freescale i.MX23/i.MX28
+
+Required properties:
+- compatible:
+  - "fsl,imx23-power" for i.MX23
+  - "fsl,imx28-power" for i.MX28
+- address-cells, size-cells, ranges: must be present as appropriate to
+  map children
+- reg: Address and length of the register set for the power subsystem.
+
+Optional properties;
+- interrupts: Interrupts used by the power subsystem
+
+Example for i.MX28:
+
+	power: power at 80044000 {
+				compatible = "fsl,imx28-power";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x80044000 0x2000>;
+				interrupts = <6>;
+				ranges;
+	}
-- 
1.7.9.5
