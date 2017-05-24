From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Wed, 24 May 2017 15:43:18 +0800
Subject: [PATCH] arm64: perf: Extend event config for ARMv8.1
Message-ID: <1495611798-240082-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perf has supported ARMv8.1 feature with 16-bit evtCount filed [see c210ae8
arm64: perf: Extend event mask for ARMv8.1], event config should be
extended to 16-bit too, otherwise, if use -e event_name whose event_code
is more than 0x3ff, pmu_config_term will return -EINVAL because function
pmu_format_max_value depends on event config.

This patch extends event config to 16-bit.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 83a1b1a..b5798ba 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -529,7 +529,7 @@
 	.is_visible = armv8pmu_event_attr_is_visible,
 };
 
-PMU_FORMAT_ATTR(event, "config:0-9");
+PMU_FORMAT_ATTR(event, "config:0-15");
 
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
-- 
1.9.1
