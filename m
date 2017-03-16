From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:30:33 +0100
Subject: [PATCH v2 6/7] memory: atmel-ebi: Add missing ->numcs assignment
In-Reply-To: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1489653034-17777-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ebid->numcs is never assigned, set it to numcs after allocating the
EBI dev object.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/memory/atmel-ebi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 8beba9a60d1c..7d24a957e98c 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -332,6 +332,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
 		return -ENOMEM;
 
 	ebid->ebi = ebi;
+	ebid->numcs = numcs;
 
 	ret = caps->xlate_config(ebid, np, &conf);
 	if (ret < 0)
-- 
2.7.4
