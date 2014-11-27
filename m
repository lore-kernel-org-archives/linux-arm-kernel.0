From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 27 Nov 2014 13:07:31 +0800
Subject: [PATCH v2 1/3] ACPI / processor: Update the comments in processor.h
In-Reply-To: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
References: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
Message-ID: <1417064853-27905-2-git-send-email-hanjun.guo@linaro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

In commit 46ba51e (ACPI / processor: Introduce ARCH_MIGHT_HAVE_ACPI_PDC),
acpi_processor_set_pdc() was moved to processor_pdc.c, so update
the comments accordingly.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/processor.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 9b9b6f2..cbb6cd3 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -313,11 +313,13 @@ static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 #endif				/* CONFIG_CPU_FREQ */
 
 /* in processor_core.c */
-void acpi_processor_set_pdc(acpi_handle handle);
 int acpi_get_apicid(acpi_handle, int type, u32 acpi_id);
 int acpi_map_cpuid(int apic_id, u32 acpi_id);
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 
+/* in processor_pdc.c */
+void acpi_processor_set_pdc(acpi_handle handle);
+
 /* in processor_throttling.c */
 int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
-- 
1.9.1
