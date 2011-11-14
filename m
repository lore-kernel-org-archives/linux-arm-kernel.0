From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Nov 2011 16:19:25 +0000
Subject: [PATCH] ARM: perf: re-export release_pmu symbol to modules
Message-ID: <1321287565-27045-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b0e89590 ("ARM: PMU: move CPU PMU platform device handling and
init into perf") inadvertently removed the EXPORT_SYMBOL_GPL on
release_pmu, so out-of-tree modules can no longer play nice with perf,
even if they tried in the first place.

This patch re-exports the symbol.

Reported-by: Jon Medhurst (Tixy) <jon.medhurst@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/pmu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index 2c3407e..2334bf8 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -33,3 +33,4 @@ release_pmu(enum arm_pmu_type type)
 {
 	clear_bit_unlock(type, pmu_lock);
 }
+EXPORT_SYMBOL_GPL(release_pmu);
-- 
1.7.4.1
