From: Gang.Liu@nxp.com (Liu Gang)
Date: Wed, 23 Mar 2016 17:47:19 +0800
Subject: [PATCH] dt-bindings: Add new platforms GPIO node description
Message-ID: <1458726442-1851-1-git-send-email-Gang.Liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the NXP GPIO node dt-binding file for QorIQ and
Layerscape platforms, and add one more example with
ls2080a GPIO node.

Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
---
 .../devicetree/bindings/gpio/gpio-mpc8xxx.txt        | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
index 120bc49..4b6cc63 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
@@ -1,9 +1,10 @@
-* Freescale MPC512x/MPC8xxx/Layerscape GPIO controller
+* Freescale MPC512x/MPC8xxx/QorIQ/Layerscape GPIO controller
 
 Required properties:
 - compatible : Should be "fsl,<soc>-gpio"
   The following <soc>s are known to be supported:
-    mpc5121, mpc5125, mpc8349, mpc8572, mpc8610, pq3, qoriq.
+	mpc5121, mpc5125, mpc8349, mpc8572, mpc8610, pq3, qoriq,
+	ls1021a, ls1043a, ls2080a.
 - reg : Address and length of the register set for the device
 - interrupts : Should be the port interrupt shared by all 32 pins.
 - #gpio-cells : Should be two.  The first cell is the pin number and
@@ -15,7 +16,7 @@ Optional properties:
 - little-endian : GPIO registers are used as little endian. If not
                   present registers are used as big endian by default.
 
-Example:
+Example of gpio-controller node for a mpc5125 SoC:
 
 gpio0: gpio at 1100 {
 	compatible = "fsl,mpc5125-gpio";
@@ -24,3 +25,16 @@ gpio0: gpio at 1100 {
 	interrupts = <78 0x8>;
 	status = "okay";
 };
+
+Example of gpio-controller node for a ls2080a SoC:
+
+gpio0: gpio at 2300000 {
+	compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
+	reg = <0x0 0x2300000 0x0 0x10000>;
+	interrupts = <0 36 0x4>; /* Level high type */
+	gpio-controller;
+	little-endian;
+	#gpio-cells = <2>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
-- 
2.1.0.27.g96db324
