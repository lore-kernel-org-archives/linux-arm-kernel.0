From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 22 May 2015 00:16:51 +0800
Subject: [PATCH v3 5/6] document: devicetree: input: imx: i.mx snvs power
 device tree bindings
In-Reply-To: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1432225012-20598-6-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

The snvs-pwrkey is designed to enable POWER key function which controlled
by SNVS ONOFF. the driver can report the status of POWER key and wakeup
system if pressed after system suspend.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
Signed-off-by: Robin Gong <b38343@freescale.com>
---
 .../devicetree/bindings/crypto/fsl-sec4.txt        | 42 ++++++++++++++++++++++
 .../devicetree/bindings/input/snvs-pwrkey.txt      |  1 +
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index 87f5921..b2a417d 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -375,6 +375,41 @@ EXAMPLE
 	};
 
 =====================================================================
+System ON/OFF key driver
+
+  The snvs-pwrkey is designed to enable POWER key function which controlled
+  by SNVS ONOFF, the driver can report the status of POWER key and wakeup
+  system if pressed after system suspend.
+
+  - compatible:
+      Usage: required
+      Value type: <string>
+      Definition: Mush include "fsl,sec-v4.0-pwrkey".
+
+  - interrupts:
+      Usage: required
+      Value type: <prop_encoded-array>
+      Definition: The SNVS ON/OFF interrupt number to the CPU(s).
+
+  - linux,keycode:
+      Usage: option
+      Value type: <int>
+      Definition: Keycode to emit, KEY_POWER by default.
+
+  - wakeup:
+      Usage: option
+      Value type: <boo>
+      Definition: Button can wake-up the system
+
+EXAMPLE:
+	snvs-pwrkey at 0x020cc000 {
+		compatible = "fsl,sec-v4.0-pwrkey";
+		interrupts = <0 4 0x4>
+	        linux,keycode = <116>; /* KEY_POWER */
+		wakeup;
+	};
+
+=====================================================================
 FULL EXAMPLE
 
 	crypto: crypto at 300000 {
@@ -452,6 +487,13 @@ FULL EXAMPLE
 			compatible = "fsl,sec-v4.0-mon-rtc-lp";
 			interrupts = <93 2>;
 		};
+
+		snvs-pwrkey at 0x020cc000 {
+			compatible = "fsl,sec-v4.0-pwrkey";
+			interrupts = <0 4 0x4>;
+			linux,keycode = <116>; /* KEY_POWER */
+			wakeup;
+		};
 	};
 
 =====================================================================
diff --git a/Documentation/devicetree/bindings/input/snvs-pwrkey.txt b/Documentation/devicetree/bindings/input/snvs-pwrkey.txt
new file mode 100644
index 0000000..70c1425
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/snvs-pwrkey.txt
@@ -0,0 +1 @@
+See Documentation/devicetree/bindings/crypto/fsl-sec4.txt
-- 
1.9.1
