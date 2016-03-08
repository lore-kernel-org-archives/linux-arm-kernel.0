From: jglauber@cavium.com (Jan Glauber)
Date: Tue,  8 Mar 2016 13:14:33 +0100
Subject: [PATCH] bus: arm-ccn: Fix cpu notifier priority
Message-ID: <1457439273-5998-1-git-send-email-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix cpu priority of notifier block that was erroneously set to
return value of next statement.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/bus/arm-ccn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 7082c72..d4a939e 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -1271,7 +1271,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	 * picked to have a chance to migrate events before perf is notified.
 	 */
 	ccn->dt.cpu_nb.notifier_call = arm_ccn_pmu_cpu_notifier;
-	ccn->dt.cpu_nb.priority = CPU_PRI_PERF + 1,
+	ccn->dt.cpu_nb.priority = CPU_PRI_PERF + 1;
 	err = register_cpu_notifier(&ccn->dt.cpu_nb);
 	if (err)
 		goto error_cpu_notifier;
-- 
1.9.1
