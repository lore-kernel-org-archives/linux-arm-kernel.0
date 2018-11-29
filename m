From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 29 Nov 2018 02:37:24 +0000
Subject: [PATCH V4 1/4] dt-bindings: fsl: scu: add thermal binding
In-Reply-To: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1543458696-4741-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and thermal sensors etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get temperature from thermal sensors, this patch adds
binding doc for i.MX system controller thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog:
V3->V4:
  *move binding doc to SCU since it is belonging to SCU;
  *change compatile string to start with "fsl" instead of "nxp" to align with other nodes in dtb.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 3f3d697..b77ec29 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -112,6 +112,16 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
 
+Thermal bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible : Must be "fsl,imx8qxp-sc-thermal";
+- tsens-num : Total number of thermal sensors supported;
+- #thermal-sensor-cells : Should be 1. See
+			  Documentation/devicetree/bindings/thermal/thermal.txt
+			  for a description.
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox at 5d1c0000 {
@@ -158,6 +168,12 @@ firmware {
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible = "fsl,imx8qxp-sc-thermal";
+			tsens-num = <1>;
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
 
-- 
2.7.4
