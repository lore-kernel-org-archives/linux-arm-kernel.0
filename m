From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 28 Jun 2016 05:50:24 -0400
Subject: [PATCH 3/8] arm64:perf: Update Kconfig for Hisilicon PMU support
In-Reply-To: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1467107429-55477-4-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Update Kconfig for Hisilicon SoC ARMv8 PMU support.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 04e2653..a90b2fc 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -12,4 +12,13 @@ config ARM_PMU
 	  Say y if you want to use CPU performance monitors on ARM-based
 	  systems.
 
+config HISI_PERFCTR
+	bool "Enable hardware event counter support for HiSilicon SoC"
+	depends on HW_PERF_EVENTS && ARM64
+	select HISI_DJTAG
+	default n
+	help
+	  Enable hardware event counter support for hardware event counters
+	  in Hisilicon Hi161x SoC. The hardware modules like LLC, MN1 and
+	  DDRC have hardware events and counters.
 endmenu
-- 
2.1.4
