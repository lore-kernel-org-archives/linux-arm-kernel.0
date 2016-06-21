From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 18:49:12 +0100
Subject: [PATCH] usb: musb: sunxi: make unexported symbols static
Message-ID: <1466531352-2864-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi_musb_dma_controller_create and _destroy are not exported
or used outside the driver, so fix sparse warnings by making these
two static:

drivers/usb/musb/sunxi.c:357:23: warning: symbol 'sunxi_musb_dma_controller_create' was not declared. Should it be static?
drivers/usb/musb/sunxi.c:363:6: warning: symbol 'sunxi_musb_dma_controller_destroy' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Bin Liu <b-liu@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-usb at vger.kernel.or
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/usb/musb/sunxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 7650051..8522081 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -354,13 +354,13 @@ static void sunxi_musb_disable(struct musb *musb)
 	clear_bit(SUNXI_MUSB_FL_ENABLED, &glue->flags);
 }
 
-struct dma_controller *sunxi_musb_dma_controller_create(struct musb *musb,
-						    void __iomem *base)
+static struct dma_controller *
+sunxi_musb_dma_controller_create(struct musb *musb, void __iomem *base)
 {
 	return NULL;
 }
 
-void sunxi_musb_dma_controller_destroy(struct dma_controller *c)
+static void sunxi_musb_dma_controller_destroy(struct dma_controller *c)
 {
 }
 
-- 
2.8.1
