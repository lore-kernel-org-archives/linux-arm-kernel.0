From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:13:33 +0100
Subject: [PATCH 1/2] ARM: shmobile: Document DT bindings for Product Register
In-Reply-To: <cover.1479928995.git.horms+renesas@verge.net.au>
References: <cover.1479928995.git.horms+renesas@verge.net.au>
Message-ID: <5384f45cd9714287f198771bfb057eda799af9a8.1479928995.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add device tree binding documentation for the Product Register (PRR),
which provides product and revision information on most Renesas ARM
SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 2f0b7169f132..23c77315fdac 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -75,3 +75,21 @@ Boards:
     compatible = "renesas,silk", "renesas,r8a7794"
   - Wheat
     compatible = "renesas,wheat", "renesas,r8a7792"
+
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
-- 
2.7.0.rc3.207.g0ac5344
