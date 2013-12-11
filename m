From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 13:13:21 +0000
Subject: [PATCH 1/6] arm64: Add asm/cpu.h
Message-ID: <1386767606-6391-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

In order to implement both topology and ACPI support we need to define
per-CPU data.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/include/asm/cpu.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpu.h

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
new file mode 100644
index 000000000000..d67ff011d361
--- /dev/null
+++ b/arch/arm64/include/asm/cpu.h
@@ -0,0 +1,25 @@
+/*
+ *  Copyright (C) 2004-2005 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARM64_CPU_H
+#define __ASM_ARM64_CPU_H
+
+#include <linux/percpu.h>
+#include <linux/cpu.h>
+#include <linux/topology.h>
+
+struct cpuinfo_arm {
+	struct cpu	cpu;
+	u64		cpuid;
+#ifdef CONFIG_SMP
+	unsigned int	loops_per_jiffy;
+#endif
+};
+
+DECLARE_PER_CPU(struct cpuinfo_arm, cpu_data);
+
+#endif
-- 
1.8.5.1
