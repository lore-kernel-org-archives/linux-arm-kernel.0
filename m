From: leiwen@marvell.com (Lei Wen)
Date: Sun, 19 Sep 2010 11:22:16 +0800
Subject: [PATCH] ARM: make app read out process num even not use SMP
Message-ID: <1284866536-21431-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some app like trace-cmd need to know the process number, but not
all arm board is enabled with the SMP. Add this fix up to let those
app works happy.

Signed-off-by: Lei Wen<leiwen@marvell.com>
Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/kernel/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d5231ae..1af3e2d 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -917,6 +917,7 @@ static int c_show(struct seq_file *m, void *v)
 			   (per_cpu(cpu_data, i).loops_per_jiffy / (5000UL/HZ)) % 100);
 	}
 #else /* CONFIG_SMP */
+	seq_printf(m, "processor\t: 0\n");
 	seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
 		   loops_per_jiffy / (500000/HZ),
 		   (loops_per_jiffy / (5000/HZ)) % 100);
-- 
1.7.0.4
