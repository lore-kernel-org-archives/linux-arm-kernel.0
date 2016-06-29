From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu, 30 Jun 2016 02:15:49 +0800
Subject: [PATCH v6 06/10] acpi: Add GTDT driver to kernel build system
In-Reply-To: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1467224153-22873-7-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/acpi/Kconfig  | 9 +++++++++
 drivers/acpi/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b7e2e77..27a5cf9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -521,4 +521,13 @@ config XPOWER_PMIC_OPREGION
 
 endif
 
+config ACPI_GTDT
+	bool "ACPI GTDT Support"
+	depends on ARM64
+	help
+	  GTDT (Generic Timer Description Table) provides information
+	  for per-processor timers and Platform (memory-mapped) timers
+	  for ARM platforms. Select this option to provide information
+	  needed for the timers init.
+
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 251ce85..848aa8a 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
 obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
 obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
+obj-$(CONFIG_ACPI_GTDT)		+= acpi_gtdt.o
 
 video-objs			+= acpi_video.o video_detect.o
-- 
2.5.5
