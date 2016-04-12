From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 12 Apr 2016 17:12:57 -0500
Subject: [PATCH 2/6] EDAC, altera: Move IRQ function declaration
In-Reply-To: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1460499181-23080-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for additional memory module ECCs, the
IRQ declaration is being made available to everyone.
Move it outside of the OCRAM only area.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/edac/altera_edac.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index c3e040d..226e650 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -848,6 +848,10 @@ static struct platform_driver altr_edac_device_driver = {
 };
 module_platform_driver(altr_edac_device_driver);
 
+/********************* Arria10 Function Declarations *********************/
+static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
+					 bool sberr);
+
 /*********************** OCRAM EDAC Device Functions *********************/
 
 #ifdef CONFIG_EDAC_ALTERA_OCRAM
@@ -902,9 +906,6 @@ const struct edac_device_prv_data ocramecc_data = {
 	.inject_fops = &altr_edac_device_inject_fops,
 };
 
-static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
-					 bool sberr);
-
 const struct edac_device_prv_data a10_ocramecc_data = {
 	.setup = altr_check_ecc_deps,
 	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
-- 
1.7.9.5
