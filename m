From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Nov 2014 20:30:05 +0000
Subject: [PATCH 5/8] ARM: remove "SMP: Total of %d processors activated."
 message
In-Reply-To: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
Message-ID: <E1XqSw1-0002EV-HN@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "SMP: Total of %d processors activated." message which we print in
smp_cpus_done() provides no further information than the message in
genreic code in smp_announce().  Kill it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 7b18a1be179c..5e6052e18850 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -387,9 +387,6 @@ asmlinkage void secondary_start_kernel(void)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-	pr_info("SMP: Total of %d processors activated.\n",
-		num_online_cpus());
-
 	hyp_mode_check();
 }
 
-- 
1.8.3.1
