From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:36 +0000
Subject: [PATCHv5 13/16] Documentation: Add ARMv8 to arch_timer devicetree
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-14-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the documentation for the arch_timer devicetree binding only
lists "arm,armv7-timer".

Add "arm,armv8-timer" to the list of compatible strings.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 Documentation/devicetree/bindings/arm/arch_timer.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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
1.8.1.1
