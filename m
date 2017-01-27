From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Jan 2017 10:10:36 +0100
Subject: [PATCH 1/2] memory: atmel-ebi: Fix the test to enable generic SMC
 logic
In-Reply-To: <1485508237-30178-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1485508237-30178-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1485508237-30178-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should test the apply value and not the ret one here.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes: 6a4ec4cd0888 ("memory: add Atmel EBI (External Bus Interface) driver")
---
 drivers/memory/atmel-ebi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 1eaaa2be8ff2..2c4c9a1978bc 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -503,7 +503,7 @@ static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
 		 * Attach the EBI device to the generic SMC logic if at least
 		 * one "atmel,smc-" property is present.
 		 */
-		if (ebi->ebi_csa && ret)
+		if (ebi->ebi_csa && apply)
 			regmap_field_update_bits(ebi->ebi_csa,
 						 BIT(cs), 0);
 	}
-- 
2.7.4
