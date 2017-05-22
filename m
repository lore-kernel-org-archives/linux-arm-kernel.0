From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Mon, 22 May 2017 20:48:29 +0800
Subject: [PATCH v8 5/9] drivers: perf: hisi: Update Kconfig for Hisilicon PMU
 support
Message-ID: <1495457309-236380-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anurup M <anurup.m@huawei.com>

Update Kconfig for HiP05/06/07 PMU support.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index aa587ed..4bc1f09 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -16,6 +16,14 @@ config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
 
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
1.9.1
