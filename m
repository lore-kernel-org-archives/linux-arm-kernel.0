From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  5 Sep 2016 16:27:53 +0100
Subject: [PATCH] arm-cci: pmu: Fix typo in event name
Message-ID: <1473089273-19311-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For one of the CCI events exposed under sysfs, "snoop" was typo'd as
"snopp". Correct this such that users see the expected event name when
enumerating events via sysfs.

Cc: arm at kernel.org
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 5755907f..ffa7c9d 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -551,7 +551,7 @@ static struct attribute *cci5xx_pmu_event_attrs[] = {
 	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_wrq, 0xB),
 	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_cd_hs, 0xC),
 	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_rq_stall_addr_hazard, 0xD),
-	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snopp_rq_stall_tt_full, 0xE),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_rq_stall_tt_full, 0xE),
 	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_rq_tzmp1_prot, 0xF),
 	NULL
 };
-- 
2.7.4
