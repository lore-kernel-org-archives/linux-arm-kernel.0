From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 16:01:54 +0000
Subject: [PATCH] ARM: PMU: remove pmu_init declaration
Message-ID: <1321459314-25668-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pmu_init no longer exists, so don't declare it in asm/pmu.h.

Reported-by: Pawel Moll <Pawel.Moll@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 71d99b8..0bda22c 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -55,16 +55,6 @@ reserve_pmu(enum arm_pmu_type type);
 extern void
 release_pmu(enum arm_pmu_type type);
 
-/**
- * init_pmu() - Initialise the PMU.
- *
- * Initialise the system ready for PMU enabling. This should typically set the
- * IRQ affinity and nothing else. The users (oprofile/perf events etc) will do
- * the actual hardware initialisation.
- */
-extern int
-init_pmu(enum arm_pmu_type type);
-
 #else /* CONFIG_CPU_HAS_PMU */
 
 #include <linux/err.h>
-- 
1.7.4.1
