From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Thu, 30 Aug 2018 23:00:05 +0200
Subject: [PATCH v2 01/12] fbdev: show fbdev number for debugging
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
Message-ID: <ef584ecd8642e8b1a04f28d6d9c1864b5aa507bb.1535656077.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index f741ba8df01b..30a18d4c9de4 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1618,8 +1618,8 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			(primary && gen_aper && gen_aper->count &&
 			 gen_aper->ranges[0].base == VGA_FB_PHYS)) {
 
-			printk(KERN_INFO "fb: switching to %s from %s\n",
-			       name, registered_fb[i]->fix.id);
+			printk(KERN_INFO "fb%d: switching to %s from %s\n",
+			       i, name, registered_fb[i]->fix.id);
 			ret = do_unregister_framebuffer(registered_fb[i]);
 			if (ret)
 				return ret;
-- 
2.18.0
