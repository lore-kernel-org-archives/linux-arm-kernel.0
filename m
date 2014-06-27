From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 27 Jun 2014 11:49:33 +0800
Subject: [PATCH v4 10/13] ACPI: Make EC debugfs depend on X86 || IA64 in
 Kconfig
In-Reply-To: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1403840976-7456-11-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since EC (Embedded controller) needs SCI for the interupt which
is not available on ARM64, make the EC debugfs depend on X86 || IA64
only in the Kconfig file.

Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0e6f72d..7de5e3f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -69,6 +69,7 @@ config ACPI_PROCFS_POWER
 
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
+	depends on X86 || IA64
 	default n
 	help
 	  Say N to disable Embedded Controller /sys/kernel/debug interface
-- 
1.7.9.5
