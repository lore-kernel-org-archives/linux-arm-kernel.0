From: robh@kernel.org (Rob Herring)
Date: Wed, 29 Aug 2018 15:04:25 -0500
Subject: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
Message-ID: <20180829200425.16435-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the of_get_child_by_name() helper instead of open coding searching
for the 'firmware' child node. This removes directly accessing the name
pointer as well.

Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/fsl/qe/qe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2ef6fc6487c1..612d9c551be5 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -588,11 +588,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 	}
 
 	/* Find the 'firmware' child node */
-	for_each_child_of_node(qe, fw) {
-		if (strcmp(fw->name, "firmware") == 0)
-			break;
-	}
-
+	fw = of_get_child_by_name(qe, "firmware");
 	of_node_put(qe);
 
 	/* Did we find the 'firmware' node? */
-- 
2.17.1
