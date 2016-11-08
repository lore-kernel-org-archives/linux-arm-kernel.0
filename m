From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue,  8 Nov 2016 17:55:47 +0000
Subject: [PATCH 2/2] drivers: psci: Allow PSCI node to be disabled
In-Reply-To: <20161108175547.31146-1-lorenzo.pieralisi@arm.com>
References: <20161108175547.31146-1-lorenzo.pieralisi@arm.com>
Message-ID: <20161108175547.31146-2-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Allow disabling PSCI support (mostly for testing purposes) by setting
the status property to "disabled". This makes the node behave in much
the same way as proper device nodes.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/firmware/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 8263429..6c60a50 100644
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
