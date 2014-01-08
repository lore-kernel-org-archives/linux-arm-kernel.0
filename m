From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  8 Jan 2014 14:59:38 -0800
Subject: [PATCH 1/7] ARM: perf_event: Silence sparse warning
In-Reply-To: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
References: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389221984-10973-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/kernel/perf_event_cpu.c:274:25: warning: incorrect type in assignment (different modifiers)
arch/arm/kernel/perf_event_cpu.c:274:25: expected int ( *init_fn )( ... )
arch/arm/kernel/perf_event_cpu.c:274:25: got void const *const data

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/perf_event_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index d85055cd24ba..20d553c9f5e2 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -254,7 +254,7 @@ static int probe_current_pmu(struct arm_pmu *pmu)
 static int cpu_pmu_device_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
-	int (*init_fn)(struct arm_pmu *);
+	const int (*init_fn)(struct arm_pmu *);
 	struct device_node *node = pdev->dev.of_node;
 	struct arm_pmu *pmu;
 	int ret = -ENODEV;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
