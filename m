From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 13 Jun 2013 19:47:09 +0530
Subject: [PATCH v2 1/3] ARM: OMAP: dma: Remove the wrong dev_id check
In-Reply-To: <1371133031-29229-1-git-send-email-rnayak@ti.com>
References: <1371133031-29229-1-git-send-email-rnayak@ti.com>
Message-ID: <1371133031-29229-2-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: R Sricharan <r.sricharan@ti.com>

Once a free channel is found, the check for dev_id == 0 does
not make any sense. Get rid of it.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/plat-omap/dma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index e06c34b..2f99331 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -701,8 +701,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
 			free_ch = ch;
-			if (dev_id == 0)
-				break;
+			/* Exit after first free channel found */
+			break;
 		}
 	}
 	if (free_ch == -1) {
-- 
1.7.9.5
