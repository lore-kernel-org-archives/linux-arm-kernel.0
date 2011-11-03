From: zonque@gmail.com (Daniel Mack)
Date: Thu,  3 Nov 2011 12:24:42 +0100
Subject: [PATCH] mmc: omap_hsmmc: fix typo around pr_info() call
Message-ID: <1320319482-9809-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was introduced by a3c76eb9 ("mmc: replace printk with appropriate
display macro").

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e8ff123..101cd31 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 		}
 	} else {
 		if (!host->protect_card) {
-			pr_info"%s: cover is open, "
+			pr_info("%s: cover is open, "
 					 "card is now inaccessible\n",
 					 mmc_hostname(host->mmc));
 			host->protect_card = 1;
-- 
1.7.6.4
