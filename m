From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  1 Dec 2017 16:23:24 -0600
Subject: [PATCH v5 3/9] ACPI: Enable PPTT support on ARM64
In-Reply-To: <20171201222330.18863-1-jeremy.linton@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
Message-ID: <20171201222330.18863-4-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a PPTT parser, in preparation for its use
on arm64, lets build it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig    | 1 +
 drivers/acpi/Kconfig  | 3 +++
 drivers/acpi/Makefile | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a93339f5178f..e62fd1e08c1f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,6 +7,7 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 46505396869e..df7aebf0af0e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -545,6 +545,9 @@ config ACPI_CONFIGFS
 
 if ARM64
 source "drivers/acpi/arm64/Kconfig"
+
+config ACPI_PPTT
+	bool
 endif
 
 config TPS68470_PMIC_OPREGION
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 41954a601989..b6056b566df4 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
+obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
-- 
2.13.5
