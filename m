From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Apr 2016 13:30:13 +0100
Subject: [PATCH v4 5/5] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
In-Reply-To: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1461069013-13292-6-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ACPI processor idle driver supports LPI(Low Power Idle), lets
enable ACPI_PROCESSOR_IDLE for ARM64

Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ec289078667c..33780ae005fc 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -237,7 +237,7 @@ config ACPI_CPPC_LIB
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || IA64 || ARM64
-	select ACPI_PROCESSOR_IDLE if X86 || IA64
+	select ACPI_PROCESSOR_IDLE
 	select ACPI_CPU_FREQ_PSS if X86 || IA64
 	default y
 	help
-- 
1.9.1
