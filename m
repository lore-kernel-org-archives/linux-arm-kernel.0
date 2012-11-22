From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Thu, 22 Nov 2012 17:23:39 +0900
Subject: [PATCH shmobile/DT 2/2] ARM: shmobile: Update document for sh_intc of
 DT
In-Reply-To: <1353572619-29098-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1353572619-29098-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <1353572619-29098-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delete "renesas,sh_intcs" and "renesas,sh_intca_irq_pins" as compatible.
This updates the information about these.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 Documentation/devicetree/bindings/sh/intc.txt |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/sh/intc.txt b/Documentation/devicetree/bindings/sh/intc.txt
index ebb2398..04b7f73 100644
--- a/Documentation/devicetree/bindings/sh/intc.txt
+++ b/Documentation/devicetree/bindings/sh/intc.txt
@@ -7,10 +7,7 @@ is managed by DT, in order to maintain compatibility.
 
 Main node required properties:
 
-- compatible : should be one of:
-	"renesas,sh_intca"
-	"renesas,sh_intcs"
-	"renesas,sh_intca_irq_pins"
+- compatible : "renesas,sh_intc"
 
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells	: Set already 1.
@@ -100,18 +97,10 @@ Optional:
 	This node required properties:
 	  * vector : This specifies the address phandle of INTCS.
 
-Note:
-- "renesas,sh_intca" needs group_size, intc_group*, intc_vectors,
-  intc_mask_registers and intc_prio_registers.
-- "renesas,sh_intcs" needs group_size, intc_group*, intc_vectors,
-  intc_mask_registers, intc_prio_registers and  intc_intevtsa.
-- "renesas,sh_intca_irq_pins" needs intc_vectors, intc_mask_registers,
-  intc_prio_registers, intc_sense_registers and intc_ack_registers.
-
 Example:
 
 	intca: interrupt-controller at 0 {
-		compatible = "renesas,sh_intca";
+		compatible = "renesas,sh_intc";
 		interrupt-controller;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.10.4
