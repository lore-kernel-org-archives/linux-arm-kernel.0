From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 18 Jun 2013 18:07:02 +0100
Subject: [PATCH 3/4] ARM/ARM64: arch_timer: remove __cpuinit attribute for
 arch_counter_set_user_access
In-Reply-To: <1371575223-21702-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1371575223-21702-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1371575223-21702-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

We must not declare arch_counter_set_user_access as __cpuinit as we
need to use it in warm reset paths like CPU PM notifiers.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/arch_timer.h   | 2 +-
 arch/arm64/include/asm/arch_timer.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 6725017..26c65ae 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -89,7 +89,7 @@ static inline u64 arch_counter_get_cntvct(void)
 	return cval;
 }
 
-static inline void __cpuinit arch_counter_set_user_access(int divider)
+static inline void arch_counter_set_user_access(int divider)
 {
 	u32 cntkctl;
 
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 2269944..3494102 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -97,7 +97,7 @@ static inline u32 arch_timer_get_cntfrq(void)
 	return val;
 }
 
-static inline void __cpuinit arch_counter_set_user_access(int divider)
+static inline void arch_counter_set_user_access(int divider)
 {
 	u32 cntkctl;
 
-- 
1.8.1.2
