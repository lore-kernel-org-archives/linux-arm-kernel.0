From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 20 Oct 2015 14:05:24 +0100
Subject: [PATCHv2 2/4] arm-cci: Get the status of a counter
In-Reply-To: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445346326-30820-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper routines to get the counter status and the event
programmed on it.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: arm at kernel.org
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 5435d87..1a75010 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -647,11 +647,21 @@ static void pmu_enable_counter(struct cci_pmu *cci_pmu, int idx)
 	pmu_write_register(cci_pmu, 1, idx, CCI_PMU_CNTR_CTRL);
 }
 
+static u32 pmu_get_counter_ctrl(struct cci_pmu *cci_pmu, int idx)
+{
+	return pmu_read_register(cci_pmu, idx, CCI_PMU_CNTR_CTRL) & 0x1;
+}
+
 static void pmu_set_event(struct cci_pmu *cci_pmu, int idx, unsigned long event)
 {
 	pmu_write_register(cci_pmu, event, idx, CCI_PMU_EVT_SEL);
 }
 
+static u32 pmu_get_event(struct cci_pmu *cci_pmu, int idx)
+{
+	return pmu_read_register(cci_pmu, idx, CCI_PMU_EVT_SEL);
+}
+
 /*
  * Returns the number of programmable counters actually implemented
  * by the cci
-- 
1.7.9.5
