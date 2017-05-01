From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Tue,  2 May 2017 00:39:13 +0200
Subject: [PATCH 1/1] arm64: Always provide "model name" in /proc/cpuinfo
Message-ID: <20170501223913.6894-1-xypron.glpk@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to hide the model name in processes
that are not PER_LINUX32.

So let us always provide a model name that is easily readable.

Fixes: e47b020a323d ("arm64: Provide "model name" in /proc/cpuinfo for PER_LINUX32 tasks")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/arm64/kernel/cpuinfo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index b3d5b3e8fbcb..9ad9ddcd2f19 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -118,9 +118,8 @@ static int c_show(struct seq_file *m, void *v)
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
-		if (compat)
-			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
-				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
+		seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
+			   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
 
 		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
 			   loops_per_jiffy / (500000UL/HZ),
-- 
2.11.0
