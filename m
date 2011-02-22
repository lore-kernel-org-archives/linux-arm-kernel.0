From: axel.lin@gmail.com (Axel Lin)
Date: Tue, 22 Feb 2011 11:23:53 +0800
Subject: [PATCH] davinci: cpufreq: fix section mismatch warning
Message-ID: <1298345033.3903.7.camel@mola>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix below section mismatch warning:
WARNING: vmlinux.o(.data+0x673c): Section mismatch in reference from the variable davinci_driver to the function .init.text:davinci_cpu_init()
The variable davinci_driver references
the function __init davinci_cpu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-davinci/cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
index 343de73..4a68c2b 100644
--- a/arch/arm/mach-davinci/cpufreq.c
+++ b/arch/arm/mach-davinci/cpufreq.c
@@ -132,7 +132,7 @@ out:
 	return ret;
 }
 
-static int __init davinci_cpu_init(struct cpufreq_policy *policy)
+static int davinci_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
 	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
-- 
1.7.2
