From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Jan 2013 16:07:20 +0000
Subject: [PATCHv2 11/11] Documentation: Add ARMv8 to arch_timer devicetree
In-Reply-To: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1357747640-18594-12-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../devicetree/bindings/arm/arch_timer.txt         |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
index 52478c8..20746e5 100644
--- a/Documentation/devicetree/bindings/arm/arch_timer.txt
+++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
@@ -1,13 +1,14 @@
 * ARM architected timer
 
-ARM Cortex-A7 and Cortex-A15 have a per-core architected timer, which
-provides per-cpu timers.
+ARM cores may have a per-core architected timer, which provides per-cpu timers.
 
 The timer is attached to a GIC to deliver its per-processor interrupts.
 
 ** Timer node properties:
 
-- compatible : Should at least contain "arm,armv7-timer".
+- compatible : Should at least contain one of
+	"arm,armv7-timer"
+	"arm,armv8-timer"
 
 - interrupts : Interrupt list for secure, non-secure, virtual and
   hypervisor timers, in that order.
-- 
1.7.0.4
