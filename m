From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Aug 2011 13:58:57 +0100
Subject: [PATCH 1/2] ARM: perf: fix prototype of release_pmu
Message-ID: <1312981138-17020-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f12482c9 ("ARM: 6974/1: pmu: refactor reservation") changed the
prototype of release_pmu, but missed the stub for when
CONFIG_CPU_HAS_PMU is not selected by the platform.

This patch changes the prototype of the stub, preventing possible build
failures when CONFIG_CPU_HAS_PMU is not selected.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 67c70a3..8ae32ba 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -75,7 +75,7 @@ reserve_pmu(enum arm_pmu_type device)
 }
 
 static inline int
-release_pmu(struct platform_device *pdev)
+release_pmu(enum arm_pmu_type device)
 {
 	return -ENODEV;
 }
-- 
1.7.0.4
