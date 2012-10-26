From: robherring2@gmail.com (Rob Herring)
Date: Fri, 26 Oct 2012 13:43:06 -0500
Subject: [PATCH 4/6] ARM: smp_twd: don't warn on no DT node
In-Reply-To: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
References: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
Message-ID: <1351276988-28382-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Not having a TWD is valid if we have multiple platforms with different
cores, so remove the warning message.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/smp_twd.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index e1f9069..e52e80a 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -366,10 +366,8 @@ void __init twd_local_timer_of_register(void)
 	int err;
 
 	np = of_find_matching_node(NULL, twd_of_match);
-	if (!np) {
-		err = -ENODEV;
-		goto out;
-	}
+	if (!np)
+		return -ENODEV;
 
 	twd_ppi = irq_of_parse_and_map(np, 0);
 	if (!twd_ppi) {
-- 
1.7.10.4
