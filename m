From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 10 Mar 2017 01:27:55 -0500
Subject: [PATCH v6 05/11] drivers: perf: hisi: Update Kconfig for Hisilicon
 PMU support
Message-ID: <1489127275-112691-1-git-send-email-anurup.m@huawei.com>
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
index 1e95d6a..f0aa818 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -32,4 +32,12 @@ config ARM_PMU_ACPI
 	def_bool y
 	depends on ARM_PMU && ACPI
 
+config HISI_PMU
+	bool "HiSilicon SoC PMU"
+	depends on PERF_EVENTS && ARM64
+	help
+	  Enable hardware event counter support for hardware event counters
+	  in Hisilicon HiP05/06/07 SoC. The hardware modules like L3C and MN
+	  have hardware events and counters.
+
 endmenu
-- 
2.1.4
