From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 16:54:48 +0100
Subject: [PATCH] dmaengine: sirf: fix un-exported struct warnings
Message-ID: <1465314888-31107-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sirfsoc_dmadata structs are not used outside the driver, so
remove build warnings by making them static. Fixes:

drivers/dma/sirf-dma.c:1129:24: warning: symbol 'sirfsoc_dmadata_a6' was not declared. Should it be static?
drivers/dma/sirf-dma.c:1134:24: warning: symbol 'sirfsoc_dmadata_a7v1' was not declared. Should it be static?
drivers/dma/sirf-dma.c:1139:24: warning: symbol 'sirfsoc_dmadata_a7v2' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Barry Song <baohua@kernel.org>
Cc: dmaengine at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/dma/sirf-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index e48350e..dde392d 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -1126,17 +1126,17 @@ static const struct dev_pm_ops sirfsoc_dma_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sirfsoc_dma_pm_suspend, sirfsoc_dma_pm_resume)
 };
 
-struct sirfsoc_dmadata sirfsoc_dmadata_a6 = {
+static struct sirfsoc_dmadata sirfsoc_dmadata_a6 = {
 	.exec = sirfsoc_dma_execute_hw_a6,
 	.type = SIRFSOC_DMA_VER_A6,
 };
 
-struct sirfsoc_dmadata sirfsoc_dmadata_a7v1 = {
+static struct sirfsoc_dmadata sirfsoc_dmadata_a7v1 = {
 	.exec = sirfsoc_dma_execute_hw_a7v1,
 	.type = SIRFSOC_DMA_VER_A7V1,
 };
 
-struct sirfsoc_dmadata sirfsoc_dmadata_a7v2 = {
+static struct sirfsoc_dmadata sirfsoc_dmadata_a7v2 = {
 	.exec = sirfsoc_dma_execute_hw_a7v2,
 	.type = SIRFSOC_DMA_VER_A7V2,
 };
-- 
2.8.1
