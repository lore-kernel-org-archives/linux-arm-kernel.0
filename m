From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 17 Oct 2016 12:46:53 +0200
Subject: [PATCH] drivers: psci: Allow PSCI node to be disabled
Message-ID: <20161017104653.18783-1-thierry.reding@gmail.com>
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
index 8263429e21b8..6c60a5087caf 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -630,7 +630,7 @@ int __init psci_dt_init(void)
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
-	if (!np)
+	if (!np || !of_device_is_available(np))
 		return -ENODEV;
 
 	init_fn = (psci_initcall_t)matched_np->data;
-- 
2.10.0
