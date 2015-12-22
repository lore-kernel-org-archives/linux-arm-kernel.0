From: ilya@compulab.co.il (Ilya Ledvich)
Date: Tue, 22 Dec 2015 11:10:59 +0200
Subject: [PATCH] ARM: dts: compulab: add new board description
Message-ID: <1450775459-18937-1-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description for newly introduced Compulab devices:
- CL-SOM-iMX7
- SBC-iMX7

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
---

Arnd, Olof, this patch follows the discussion in [1].
Can you please apply it on top of arm-soc next/dt branch?

Thanks!

[1] - http://www.spinics.net/lists/arm-kernel/msg470410.html

 .../devicetree/bindings/arm/compulab-boards.txt    | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/compulab-boards.txt b/Documentation/devicetree/bindings/arm/compulab-boards.txt
index 71172d5..42a1028 100644
--- a/Documentation/devicetree/bindings/arm/compulab-boards.txt
+++ b/Documentation/devicetree/bindings/arm/compulab-boards.txt
@@ -1,5 +1,25 @@
-CompuLab SB-SOM is a multi-module baseboard capable of carrying CM-T43, CM-T54,
-and CM-QS600 modules with minor modifications to the SB-SOM assembly.
+CompuLab SB-SOM is a multi-module baseboard capable of carrying:
+ - CM-T43
+ - CM-T54
+ - CM-QS600
+ - CL-SOM-AM57x
+ - CL-SOM-iMX7
+modules with minor modifications to the SB-SOM assembly.
 
 Required root node properties:
     - compatible = should be "compulab,sb-som"
+
+Compulab CL-SOM-iMX7 is a miniature System-on-Module (SoM) based on
+Freescale i.MX7 ARM Cortex-A7 System-on-Chip.
+
+Required root node properties:
+    - compatible = "compulab,cl-som-imx7", "fsl,imx7d";
+
+Compulab SBC-iMX7 is a single board computer based on the
+Freescale i.MX7 system-on-chip. SBC-iMX7 is implemented with
+the CL-SOM-iMX7 System-on-Module providing most of the functions,
+and SB-SOM-iMX7 carrier board providing additional peripheral
+functions and connectors.
+
+Required root node properties:
+    - compatible = "compulab,sbc-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
-- 
1.9.1
