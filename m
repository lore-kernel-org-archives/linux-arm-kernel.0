From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Mar 2014 17:25:50 +0100
Subject: [PATCH 1/2] ARM: dt-binding: fix GIC example
Message-ID: <1396023951-32383-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tim Harvey <tharvey@gateworks.com>

When using interrupt-maps, the size of a map entry is #address-cells +
address-cells should be 0 as this is not used.

As #address-cells = <0> is the same as not specifying the
property, simply remove it.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2 lst:
- completely remove the property
---
 Documentation/devicetree/bindings/arm/gic.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index bae0d87a38b2..42ab3b28a266 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -55,7 +55,6 @@ Example:
 	intc: interrupt-controller at fff11000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
 		interrupt-controller;
 		reg = <0xfff11000 0x1000>,
 		      <0xfff10100 0x100>;
-- 
1.9.0
