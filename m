From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 25 Dec 2017 14:07:48 +0100
Subject: [PATCH 2/2] pinctrl: single: Delete an unnecessary return statement
 in pcs_irq_chain_handler()
In-Reply-To: <6bc679d1-c1ee-52fe-9ece-b28095f653ec@users.sourceforge.net>
References: <6bc679d1-c1ee-52fe-9ece-b28095f653ec@users.sourceforge.net>
Message-ID: <c736d14b-0293-82ac-27de-a673b62b61d7@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2017 11:35:44 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pinctrl/pinctrl-single.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index f5ff2111481d..16689195e481 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1459,8 +1459,6 @@ static void pcs_irq_chain_handler(struct irq_desc *desc)
 	pcs_irq_handle(pcs_soc);
 	/* REVISIT: export and add handle_bad_irq(irq, desc)? */
 	chained_irq_exit(chip, desc);
-
-	return;
 }
 
 static int pcs_irqdomain_map(struct irq_domain *d, unsigned int irq,
-- 
2.15.1
