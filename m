From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 17 Mar 2015 16:54:50 +0530
Subject: [RESEND PATCH 1/2] ARM: dts: am4372: Add "ti,
 am437x-ocp2scp" as compatible string for OCP2SCP
Message-ID: <1426591491-3685-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added a new compatible string "ti,am437x-ocp2scp" for OCP2SCP module.
This is needed since except for the OCP2SCP used in AM437x, SYNC2 value
in OCP2SCP TIMING should be changed whereas the default value is sufficient
in AM437x.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/bus/omap-ocp2scp.txt       |    3 ++-
 arch/arm/boot/dts/am4372.dtsi                      |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
index 63dd805..18729f6 100644
--- a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
+++ b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
@@ -1,7 +1,8 @@
 * OMAP OCP2SCP - ocp interface to scp interface
 
 properties:
-- compatible : Should be "ti,omap-ocp2scp"
+- compatible : Should be "ti,am437x-ocp2scp" for AM437x processor
+	       Should be "ti,omap-ocp2scp" for all others
 - reg : Address and length of the register set for the device
 - #address-cells, #size-cells : Must be present if the device has sub-nodes
 - ranges : the child address space are mapped 1:1 onto the parent address space
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 1943fc3..286e317 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -787,7 +787,7 @@
 		};
 
 		ocp2scp0: ocp2scp at 483a8000 {
-			compatible = "ti,omap-ocp2scp";
+			compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -806,7 +806,7 @@
 		};
 
 		ocp2scp1: ocp2scp at 483e8000 {
-			compatible = "ti,omap-ocp2scp";
+			compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
1.7.9.5
