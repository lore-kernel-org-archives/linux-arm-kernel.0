From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 13 Dec 2017 18:33:34 +0100
Subject: [PATCH 1/3] soc/fsl/qe: Delete an error message for a failed memory
 allocation in three functions
In-Reply-To: <07738369-a787-98b4-41a5-71b7d630c356@users.sourceforge.net>
References: <07738369-a787-98b4-41a5-71b7d630c356@users.sourceforge.net>
Message-ID: <c979f5f0-dc1d-1e10-644a-d32e65fadf82@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 13 Dec 2017 17:45:23 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/soc/fsl/qe/gpio.c     | 4 +---
 drivers/soc/fsl/qe/ucc_fast.c | 5 +----
 drivers/soc/fsl/qe/ucc_slow.c | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 3b27075c21a7..9239cf176e67 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -143,10 +143,8 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
 	unsigned long flags;
 
 	qe_pin = kzalloc(sizeof(*qe_pin), GFP_KERNEL);
-	if (!qe_pin) {
-		pr_debug("%s: can't allocate memory\n", __func__);
+	if (!qe_pin)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	err = of_get_gpio(np, index);
 	if (err < 0)
diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
index 83d8d16e3a69..59b68bf4aebb 100644
--- a/drivers/soc/fsl/qe/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -195,11 +195,8 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	}
 
 	uccf = kzalloc(sizeof(struct ucc_fast_private), GFP_KERNEL);
-	if (!uccf) {
-		printk(KERN_ERR "%s: Cannot allocate private data\n",
-			__func__);
+	if (!uccf)
 		return -ENOMEM;
-	}
 
 	/* Fill fast UCC structure */
 	uccf->uf_info = uf_info;
diff --git a/drivers/soc/fsl/qe/ucc_slow.c b/drivers/soc/fsl/qe/ucc_slow.c
index 9334bdbd9b30..fc91412e2300 100644
--- a/drivers/soc/fsl/qe/ucc_slow.c
+++ b/drivers/soc/fsl/qe/ucc_slow.c
@@ -153,11 +153,8 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	}
 
 	uccs = kzalloc(sizeof(struct ucc_slow_private), GFP_KERNEL);
-	if (!uccs) {
-		printk(KERN_ERR "%s: Cannot allocate private data\n",
-			__func__);
+	if (!uccs)
 		return -ENOMEM;
-	}
 
 	/* Fill slow UCC structure */
 	uccs->us_info = us_info;
-- 
2.15.1
