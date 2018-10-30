From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Tue, 30 Oct 2018 17:19:59 +0100
Subject: [PATCH] usb: gadget: aspeed-vhub: constify usb_gadget_ops structure
Message-ID: <1540916399-22426-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb_gadget_ops structure can be const as it is only stored in
the ops field of a usb_gadget structure and this field is const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index f0233912bace..6b1b16b17d7d 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -438,7 +438,7 @@ static int ast_vhub_udc_stop(struct usb_gadget *gadget)
 	return 0;
 }
 
-static struct usb_gadget_ops ast_vhub_udc_ops = {
+static const struct usb_gadget_ops ast_vhub_udc_ops = {
 	.get_frame	= ast_vhub_udc_get_frame,
 	.wakeup		= ast_vhub_udc_wakeup,
 	.pullup		= ast_vhub_udc_pullup,
