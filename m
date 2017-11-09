From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu,  9 Nov 2017 15:03:05 -0600
Subject: [PATCH v4 3/9] arm64/acpi: Create arch specific cpu to acpi id helper
In-Reply-To: <20171109210311.25655-1-jeremy.linton@arm.com>
References: <20171109210311.25655-1-jeremy.linton@arm.com>
Message-ID: <20171109210311.25655-4-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Its helpful to be able to lookup the acpi_processor_id
associated with a logical cpu. Provide an arm64
helper to do this.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/acpi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 59cca1d6ec54..408e7989d3a2 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -86,6 +86,10 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
+static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
+{
+	return	acpi_cpu_get_madt_gicc(cpu)->uid;
+}
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
-- 
2.13.5
