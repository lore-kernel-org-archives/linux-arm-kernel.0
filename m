From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Aug 2015 15:56:47 +0200
Subject: [PATCH] drivers: psci: Allow PSCI node to be disabled
Message-ID: <1438955807-18574-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Allow disabling PSCI support (mostly for testing purposes) by setting
the status property to "disabled". This makes the node behave in much
the same way as proper device nodes.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/firmware/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index a6956007dd38..59e66ac2c3b6 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -351,7 +351,7 @@ int __init psci_dt_init(void)
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
-	if (!np)
+	if (!np || !of_device_is_available(np))
 		return -ENODEV;
 
 	init_fn = (psci_initcall_t)matched_np->data;
-- 
2.4.5
