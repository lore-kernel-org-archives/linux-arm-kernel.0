From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:17 -0500
Subject: [PATCH 05/36] dt-bindings: arm: renesas: Move 'renesas,
 prr' binding to its own doc
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-6-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree at vger.kernel.org
Cc: linux-renesas-soc at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/renesas,prr.txt    | 18 ++++++++++++++++++
 .../devicetree/bindings/arm/shmobile.txt       | 18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt

diff --git a/Documentation/devicetree/bindings/arm/renesas,prr.txt b/Documentation/devicetree/bindings/arm/renesas,prr.txt
new file mode 100644
index 000000000000..5000bf492f70
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/renesas,prr.txt
@@ -0,0 +1,18 @@
+Renesas Product Register
+
+Most Renesas ARM SoCs have a Product Register that allows to retrieve SoC
+product and revision information.  If present, a device node for this register
+should be added.
+
+Required properties:
+  - compatible: Must be "renesas,prr".
+  - reg: Base address and length of the register block.
+
+
+Examples
+--------
+
+	prr: chipid at ff000044 {
+		compatible = "renesas,prr";
+		reg = <0 0xff000044 0 4>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 89b4a389fbc7..619b765e5bee 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -141,21 +141,3 @@ Boards:
     compatible = "renesas,v3msk", "renesas,r8a77970"
   - Wheat (RTP0RC7792ASKB0000JE)
     compatible = "renesas,wheat", "renesas,r8a7792"
-
-
-Most Renesas ARM SoCs have a Product Register that allows to retrieve SoC
-product and revision information.  If present, a device node for this register
-should be added.
-
-Required properties:
-  - compatible: Must be "renesas,prr".
-  - reg: Base address and length of the register block.
-
-
-Examples
---------
-
-	prr: chipid at ff000044 {
-		compatible = "renesas,prr";
-		reg = <0 0xff000044 0 4>;
-	};
-- 
2.17.1
