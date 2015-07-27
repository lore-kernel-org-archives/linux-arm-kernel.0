From: klimov.linux@gmail.com (Alexey Klimov)
Date: Tue, 28 Jul 2015 00:28:44 +0300
Subject: [RFC PATCH 2/3] documentation: dt: mct: add desc of optional
 property use-cp15-phys-counter
Message-ID: <1438032524.17734.48.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
---
 .../devicetree/bindings/timer/samsung,exynos4210-mct.txt       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
index 167d5da..c7f6354 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
@@ -36,6 +36,16 @@ Required properties:
   interrupt might be specified, meaning that all local timers use the same
   per processor interrupt.
 
+Optional properties:
+
+- use-cp15-phys-counter : set to advise mct clocksource driver to use ARM
+  arch timer 64-bit counter as main counter. Access to this coprocessor
+  counter is faster than access to same counter in mct mmio region.
+  It was discovered that mct and ARM arch timer are same underlying hardware
+  on some SoCs.
+  Only supported for Exynos5-based 32-bit systems which follow the ARMv7
+  architecture.
+
 Example 1: In this example, the IP contains two local timers, using separate
 	   interrupts, so two local timer interrupts have been specified,
 	   in addition to four global timer interrupts.
-- 
2.1.4
