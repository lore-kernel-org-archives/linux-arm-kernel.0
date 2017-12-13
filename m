From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 13 Dec 2017 18:34:42 +0100
Subject: [PATCH 2/3] soc/fsl/qe: Improve a size determination in two functions
In-Reply-To: <07738369-a787-98b4-41a5-71b7d630c356@users.sourceforge.net>
References: <07738369-a787-98b4-41a5-71b7d630c356@users.sourceforge.net>
Message-ID: <24d6e67d-6bbf-5d2b-5003-79b50a84f268@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 13 Dec 2017 17:51:21 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/soc/fsl/qe/ucc_fast.c | 2 +-
 drivers/soc/fsl/qe/ucc_slow.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
index 59b68bf4aebb..2092bfdcf1bc 100644
--- a/drivers/soc/fsl/qe/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -194,7 +194,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		return -EINVAL;
 	}
 
-	uccf = kzalloc(sizeof(struct ucc_fast_private), GFP_KERNEL);
+	uccf = kzalloc(sizeof(*uccf), GFP_KERNEL);
 	if (!uccf)
 		return -ENOMEM;
 
diff --git a/drivers/soc/fsl/qe/ucc_slow.c b/drivers/soc/fsl/qe/ucc_slow.c
index fc91412e2300..c21a42c11080 100644
--- a/drivers/soc/fsl/qe/ucc_slow.c
+++ b/drivers/soc/fsl/qe/ucc_slow.c
@@ -152,7 +152,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 		return -EINVAL;
 	}
 
-	uccs = kzalloc(sizeof(struct ucc_slow_private), GFP_KERNEL);
+	uccs = kzalloc(sizeof(*uccs), GFP_KERNEL);
 	if (!uccs)
 		return -ENOMEM;
 
-- 
2.15.1
