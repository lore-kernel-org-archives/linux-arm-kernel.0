From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 17 Nov 2016 15:32:26 +0800
Subject: [PATCH next] arm64: remove "SMP: Total of %d processors activated."
 message
Message-ID: <1479367946-38771-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a common SMP boot message in generic code on all arches,
kill "SMP: Total of %d processors activated." in smp_cpus_done()
on arm64.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
Boot message on qemu.
[    0.375116] smp: Brought up 1 node, 8 CPUs
[    0.383749] SMP: Total of 8 processors activated.

 arch/arm64/kernel/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index cb87234..9db4a95 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -428,7 +428,6 @@ static void __init hyp_mode_check(void)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-	pr_info("SMP: Total of %d processors activated.\n", num_online_cpus());
 	setup_cpu_features();
 	hyp_mode_check();
 	apply_alternatives_all();
-- 
1.7.12.4
