From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 29 Apr 2015 22:32:22 +0000
Subject: [PATCH V2 1/6] DT: add binding for mxs power subsystem
In-Reply-To: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1430346747-28728-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree bindings for the Freescale MXS
on-chip power subsystem.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/power/mxs_power.txt        |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mxs_power.txt

diff --git a/Documentation/devicetree/bindings/power/mxs_power.txt b/Documentation/devicetree/bindings/power/mxs_power.txt
new file mode 100644
index 0000000..4003ef7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mxs_power.txt
@@ -0,0 +1,17 @@
+Power subsystem for Freescale i.MX23/i.MX28
+
+Required properties:
+- compatible: Should be "fsl,<soc>-power". The supported SoCs include
+  imx23 and imx28.
+- reg: Address and length of the register set for the power subsystem.
+
+Optional properties;
+- interrupts: Interrupts used by the power subsystem
+
+Example for i.MX28:
+
+	power: power at 80044000 {
+		compatible = "fsl,imx28-power", "syscon";
+		reg = <0x80044000 0x2000>;
+		interrupts = <6>;
+	}
-- 
1.7.9.5
