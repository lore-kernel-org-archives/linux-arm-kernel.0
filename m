From: shaun.ren@linux.com (Shaun Ren)
Date: Mon, 25 Jan 2016 18:27:28 -0800
Subject: [PATCH 2/2] Staging: rts5208: Add missing dma_mapping_error
In-Reply-To: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1453775248-15965-3-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index eff9a4b621..43787df 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -663,7 +663,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 		return -ENXIO;
 
 	addr = dma_map_single(&rtsx->pci->dev, buf, len, dma_dir);
-	if (!addr)
+	if (dma_mapping_error(&rtsx->pci->dev, addr))
 		return -ENOMEM;
 
 	if (card == SD_CARD)
-- 
2.7.0
