From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 22 Feb 2016 16:46:55 +0300
Subject: [PATCH 7/8] ACPI: enable ACPI_DBG2_TABLE on ARM64
In-Reply-To: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
References: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1456148818-26257-8-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SBBR mentions DBG2 as a mandatory ACPI table.
So enable it for ARM64

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/arm64/Kconfig       | 1 +
 arch/arm64/kernel/acpi.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6bb21d8..27cb5d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -3,6 +3,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_DBG2_TABLE if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7a944f7..890d36f 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -213,6 +213,8 @@ void __init acpi_boot_table_init(void)
 		if (!param_acpi_force)
 			disable_acpi();
 	}
+
+	acpi_probe_device_table(dbg2);
 }
 
 #ifdef CONFIG_ACPI_APEI
-- 
2.7.1
