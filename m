From: sumitg@nvidia.com (Sumit Gupta)
Date: Mon, 29 Aug 2016 14:32:25 +0530
Subject: [PATCH ] arm64: cpuinfo: Add "model name" in /proc/cpuinfo for 64bit
 tasks also
Message-ID: <1472461345-28219-1-git-send-email-sumitg@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed restriction of displaying model name for 32 bit tasks only.
Because of this Processor details were not displayed in
"System setting -> Details" in Ubuntu model name display is generic
and can be printed for 64 bit also.

model name : ARMv8 Processor rev X (v8l)

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/kernel/cpuinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index ed1b84fe6925..13224f533ddb 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -118,8 +118,7 @@ static int c_show(struct seq_file *m, void *v)
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
-		if (compat)
-			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
+		seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
 				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
 
 		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
-- 
2.1.4
