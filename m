From: zhangwm@marvell.com (Neil Zhang)
Date: Wed, 14 May 2014 11:08:14 +0800
Subject: [PATCH v2] ARM64: kernel: add compatible cpuinfo
Message-ID: <1400036894-16667-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print the necessary features in order to be backwards compatible with
ARMv7 and earlier version.

Signed-off-by: Neil Zhang <zhangwm@marvell.com>
---
 arch/arm64/kernel/setup.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7ec7846..a09ecfe 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -451,6 +451,11 @@ static int c_show(struct seq_file *m, void *v)
 		if (elf_hwcap & (1 << i))
 			seq_printf(m, "%s ", hwcap_str[i]);
 
+#ifdef CONFIG_COMPAT
+	seq_puts(m, "half thumb fastmult edsp tls vfp vfpv3 vfpv4 neon ");
+	seq_puts(m, "idiva idivt ");
+#endif
+
 	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
 	seq_printf(m, "CPU architecture: AArch64\n");
 	seq_printf(m, "CPU variant\t: 0x%x\n", (read_cpuid_id() >> 20) & 15);
-- 
1.7.9.5
