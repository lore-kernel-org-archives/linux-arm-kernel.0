From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Oct 2018 17:31:51 +0100
Subject: [PATCH 2/6] arm64: perf: Terminate PMU assignment statements with
 semicolons
In-Reply-To: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
References: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
Message-ID: <1539189115-16221-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a hangover from when this code used a designated initialiser, we've
been using commas to terminate the arm_pmu field assignments. Whilst
harmless, it's also weird, so replace them with semicolons instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index e213f8e867f6..ac1c5c41501d 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1109,16 +1109,16 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	if (ret)
 		return ret;
 
-	cpu_pmu->handle_irq		= armv8pmu_handle_irq,
-	cpu_pmu->enable			= armv8pmu_enable_event,
-	cpu_pmu->disable		= armv8pmu_disable_event,
-	cpu_pmu->read_counter		= armv8pmu_read_counter,
-	cpu_pmu->write_counter		= armv8pmu_write_counter,
-	cpu_pmu->get_event_idx		= armv8pmu_get_event_idx,
-	cpu_pmu->clear_event_idx	= armv8pmu_clear_event_idx,
-	cpu_pmu->start			= armv8pmu_start,
-	cpu_pmu->stop			= armv8pmu_stop,
-	cpu_pmu->reset			= armv8pmu_reset,
+	cpu_pmu->handle_irq		= armv8pmu_handle_irq;
+	cpu_pmu->enable			= armv8pmu_enable_event;
+	cpu_pmu->disable		= armv8pmu_disable_event;
+	cpu_pmu->read_counter		= armv8pmu_read_counter;
+	cpu_pmu->write_counter		= armv8pmu_write_counter;
+	cpu_pmu->get_event_idx		= armv8pmu_get_event_idx;
+	cpu_pmu->clear_event_idx	= armv8pmu_clear_event_idx;
+	cpu_pmu->start			= armv8pmu_start;
+	cpu_pmu->stop			= armv8pmu_stop;
+	cpu_pmu->reset			= armv8pmu_reset;
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
-- 
2.1.4
