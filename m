From: anurupvasu@gmail.com (Anurup M)
Date: Tue,  4 Apr 2017 06:55:57 -0400
Subject: [PATCH v7 5/9] drivers: perf: hisi: Update Kconfig for Hisilicon PMU
 support
Message-ID: <1491303357-140425-1-git-send-email-anurup.m@huawei.com>
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
index 9365190..248d730 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -12,6 +12,14 @@ config ARM_PMU
 	  Say y if you want to use CPU performance monitors on ARM-based
 	  systems.
 
+config HISI_PMU
+	bool "HiSilicon SoC PMU"
+	depends on PERF_EVENTS && ARM64
+	help
+	  Enable hardware event counter support for hardware event counters
+	  in Hisilicon HiP05/06/07 SoC. The hardware modules like L3 Cache
+	  and MN have hardware events and counters.
+
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
 	depends on ARCH_QCOM && ARM64 && PERF_EVENTS && ACPI
-- 
2.1.4
