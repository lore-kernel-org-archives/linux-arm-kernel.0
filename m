From: anurupvasu@gmail.com (Anurup M)
Date: Mon,  2 Jan 2017 01:49:52 -0500
Subject: [PATCH v3 05/10] perf: hisi: Update Kconfig for Hisilicon PMU support
Message-ID: <1483339792-24020-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Kconfig for HiP05/06/07 PMU support.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 4d5c5f9..2a5435b 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -19,4 +19,12 @@ config XGENE_PMU
         help
           Say y if you want to use APM X-Gene SoC performance monitors.
 
+config HISI_PMU
+	bool "HiSilicon SoC PMU"
+	depends on HW_PERF_EVENTS && ARM64
+	help
+	  Enable hardware event counter support for hardware event counters
+	  in Hisilicon HiP05/06/07 SoC. The hardware modules like L3C and MN
+	  have hardware events and counters.
+
 endmenu
-- 
2.1.4
