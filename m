From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 23 Feb 2017 10:26:45 +0000
Subject: [PATCH v2 10/22] ARM: Update cpu_v7_reset documentation
In-Reply-To: <20170223102657.23100-1-marc.zyngier@arm.com>
References: <20170223102657.23100-1-marc.zyngier@arm.com>
Message-ID: <20170223102657.23100-11-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_v7_reset() now takes a second parameter indicating whether
we should reboot in HYP or not. Update the documentation to
reflect this.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mm/proc-v7.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 1846ca4255d0..01d64c0b2563 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -39,13 +39,14 @@ ENTRY(cpu_v7_proc_fin)
 ENDPROC(cpu_v7_proc_fin)
 
 /*
- *	cpu_v7_reset(loc)
+ *	cpu_v7_reset(loc, hyp)
  *
  *	Perform a soft reset of the system.  Put the CPU into the
  *	same state as it would be if it had been reset, and branch
  *	to what would be the reset vector.
  *
  *	- loc   - location to jump to for soft reset
+ *	- hyp   - indicate if restart occurs in HYP mode
  *
  *	This code must be executed using a flat identity mapping with
  *      caches disabled.
-- 
2.11.0
