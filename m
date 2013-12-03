From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed,  4 Dec 2013 00:36:50 +0800
Subject: [RFC part1 PATCH 6/7] ARM64 / ACPI: Introduce lowlevel suspend
 function
In-Reply-To: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1386088611-2801-7-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

lowlevel suspend function is needed for ACPI based suspend/resume,
introduce ARM related lowlevel function in this patch.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h |    4 ++++
 drivers/acpi/plat/arm-core.c  |    7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index e9444e4..c830adc 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -79,6 +79,10 @@ void arch_fix_phys_package_id(int num, u32 slot);
 /* temperally define -1 to make acpi core compilerable */
 #define cpu_physical_id(cpu) -1
 
+/* Low-level suspend routine. */
+extern int (*acpi_suspend_lowlevel)(void);
+#define acpi_wakeup_address (0)
+
 #else	/* !CONFIG_ACPI */
 #define acpi_disabled 1		/* ACPI sometimes enabled on ARM */
 #define acpi_noirq 1		/* ACPI sometimes enabled on ARM */
diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
index 7b8e64a..2b6df56 100644
--- a/drivers/acpi/plat/arm-core.c
+++ b/drivers/acpi/plat/arm-core.c
@@ -217,3 +217,10 @@ static int __init parse_acpi(char *arg)
 	return 0;
 }
 early_param("acpi", parse_acpi);
+
+/*
+ * acpi_suspend_lowlevel() - save kernel state and suspend.
+ *
+ * TBD when when ARM/ARM64 starts to support suspend...
+ */
+int (*acpi_suspend_lowlevel)(void);
-- 
1.7.9.5
