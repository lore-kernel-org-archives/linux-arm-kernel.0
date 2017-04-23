From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:00 +0200
Subject: [PULL 50/79] ARM: Update cpu_v7_reset documentation
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-51-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

cpu_v7_reset() now takes a second parameter indicating whether
we should reboot in HYP or not. Update the documentation to
reflect this.

Tested-by: Keerthy <j-keerthy@ti.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/mm/proc-v7.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 1846ca4..01d64c0 100644
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
2.9.0
