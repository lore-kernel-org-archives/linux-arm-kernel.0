From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  4 Jan 2016 11:54:45 +0000
Subject: [PATCH v5 06/11] arm-cci: Get the status of a counter
In-Reply-To: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1451908490-2615-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper routines to check if the counter is enabled or not.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index c768ee4..a3938ef 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -660,6 +660,12 @@ static void pmu_enable_counter(struct cci_pmu *cci_pmu, int idx)
 	pmu_write_register(cci_pmu, 1, idx, CCI_PMU_CNTR_CTRL);
 }
 
+static bool __maybe_unused
+pmu_counter_is_enabled(struct cci_pmu *cci_pmu, int idx)
+{
+	return (pmu_read_register(cci_pmu, idx, CCI_PMU_CNTR_CTRL) & 0x1) != 0;
+}
+
 static void pmu_set_event(struct cci_pmu *cci_pmu, int idx, unsigned long event)
 {
 	pmu_write_register(cci_pmu, event, idx, CCI_PMU_EVT_SEL);
-- 
1.7.9.5
