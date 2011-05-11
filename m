From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 11 May 2011 12:19:57 +0200
Subject: [PATCH 2/2] pxamci: fix coding style for multi statement conditionals
In-Reply-To: <20110510203629.GB8726@opensource.wolfsonmicro.com>
References: <20110510203629.GB8726@opensource.wolfsonmicro.com>
Message-ID: <1305109197-16613-1-git-send-email-ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put parentheses around single-statement 'if' branches when the else
branch is not a single statement as suggested in
Documentation/CodingStyle Chapter 3.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 drivers/mmc/host/pxamci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 3a89fb2..fbdb21e 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -81,9 +81,9 @@ static inline void pxamci_init_ocr(struct pxamci_host *host)
 {
 	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
 
-	if (IS_ERR_OR_NULL(host->vcc))
+	if (IS_ERR_OR_NULL(host->vcc)) {
 		host->vcc = NULL;
-	else {
+	} else {
 		host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
 		if (host->pdata && host->pdata->ocr_mask)
 			dev_warn(mmc_dev(host->mmc),
-- 
1.7.5.1
