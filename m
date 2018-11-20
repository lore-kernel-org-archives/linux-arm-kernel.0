From: tiny.windzz@gmail.com (Yangtao Li)
Date: Tue, 20 Nov 2018 09:06:07 -0500
Subject: [PATCH] ARM: add of_node_put()
Message-ID: <20181120140607.20446-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 375b13f7e780..c20421f0078e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -949,6 +949,7 @@ static int __init init_machine_late(void)
 					      &system_serial);
 		if (ret)
 			system_serial = NULL;
+		of_node_put(root);
 	}
 
 	if (!system_serial)
-- 
2.17.0
