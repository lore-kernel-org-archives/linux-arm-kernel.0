From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 18:22:01 +0100
Subject: [RESEND PATCH 2/3] memory: atmel-ebi: Add missing ->numcs assignment
In-Reply-To: <1487611322-12688-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1487611322-12688-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1487611322-12688-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ebid->numcs is never assigned, set it to numcs after allocating the
EBI dev object.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/memory/atmel-ebi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 833af8d02424..06a1a136d448 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -331,6 +331,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
 		return -ENOMEM;
 
 	ebid->ebi = ebi;
+	ebid->numcs = numcs;
 
 	ret = caps->xlate_config(ebid, np, &conf);
 	if (ret < 0)
-- 
2.7.4
