From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Jan 2015 09:44:05 +0000
Subject: [PATCH v4 11/21] DT: arm,gic: kill arm,routable-irqs
In-Reply-To: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1421660655-21394-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nobody will regret it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/gic.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 8112d0c..631cb71 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -52,11 +52,6 @@ Optional
   regions, used when the GIC doesn't have banked registers. The offset is
   cpu-offset * cpu-nr.
 
-- arm,routable-irqs : Total number of gic irq inputs which are not directly
-		  connected from the peripherals, but are routed dynamically
-		  by a crossbar/multiplexer preceding the GIC. The GIC irq
-		  input line is assigned dynamically when the corresponding
-		  peripheral's crossbar line is mapped.
 Example:
 
 	intc: interrupt-controller at fff11000 {
@@ -64,7 +59,6 @@ Example:
 		#interrupt-cells = <3>;
 		#address-cells = <1>;
 		interrupt-controller;
-		arm,routable-irqs = <160>;
 		reg = <0xfff11000 0x1000>,
 		      <0xfff10100 0x100>;
 	};
-- 
2.1.4
