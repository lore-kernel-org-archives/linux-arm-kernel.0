From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Thu, 19 May 2016 19:15:15 +0300
Subject: [PATCH v2 4/5] ACPI: table upgrade: introduce
 ARCH_HAS_ACPI_TABLE_UPGRADE
In-Reply-To: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
References: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1463674518-22477-5-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to use the table upgrade feature in ARM64.
Introduce a new configuration option that allows that.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/x86/Kconfig     | 1 +
 drivers/acpi/Kconfig | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 48ac290..f60fd27 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -22,6 +22,7 @@ config X86
 	select ANON_INODES
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
+	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c204344..083da18 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -311,9 +311,12 @@ config ACPI_CUSTOM_DSDT
 	bool
 	default ACPI_CUSTOM_DSDT_FILE != ""
 
+config ARCH_HAS_ACPI_TABLE_UPGRADE
+	def_bool n
+
 config ACPI_TABLE_UPGRADE
 	bool "Allow upgrading ACPI tables via initrd"
-	depends on BLK_DEV_INITRD && X86
+	depends on BLK_DEV_INITRD && ARCH_HAS_ACPI_TABLE_UPGRADE
 	default y
 	help
 	  This option provides functionality to upgrade arbitrary ACPI tables
-- 
2.8.2
