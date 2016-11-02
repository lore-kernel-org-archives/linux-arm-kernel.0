From: anurupvasu@gmail.com (Anurup M)
Date: Wed,  2 Nov 2016 11:42:49 -0400
Subject: [PATCH v1 06/11] perf: hisi: Update Kconfig for Hisilicon PMU support
In-Reply-To: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1478101374-18778-7-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Update Kconfig for Hip05/06/07 PMU support.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 4d5c5f9..da8dd97 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -19,4 +19,13 @@ config XGENE_PMU
         help
           Say y if you want to use APM X-Gene SoC performance monitors.
 
+config HISI_PMU
+	bool "Enable hardware event counter support for HiSilicon SoC"
+	depends on HW_PERF_EVENTS && ARM64
+	depends on HISI_DJTAG
+	help
+	  Enable hardware event counter support for hardware event counters
+	  in Hisilicon hip05/06/07 SoC. The hardware modules like L3C, MN and
+	  DDRC have hardware events and counters.
+
 endmenu
-- 
2.1.4
