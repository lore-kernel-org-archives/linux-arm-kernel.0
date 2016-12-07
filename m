From: anurupvasu@gmail.com (Anurup M)
Date: Wed,  7 Dec 2016 11:56:58 -0500
Subject: [PATCH v2 05/10] perf: hisi: Update Kconfig for Hisilicon PMU support
Message-ID: <1481129818-159626-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Kconfig for Hip05/06/07 PMU support.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 4d5c5f9..2befa55 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -19,4 +19,12 @@ config XGENE_PMU
         help
           Say y if you want to use APM X-Gene SoC performance monitors.
 
+config HISI_PMU
+	bool "Enable hardware event counter support for HiSilicon SoC"
+	depends on HW_PERF_EVENTS && ARM64
+	help
+	  Enable hardware event counter support for hardware event counters
+	  in Hisilicon hip05/06/07 SoC. The hardware modules like L3C, MN and
+	  DDRC have hardware events and counters.
+
 endmenu
-- 
2.1.4
