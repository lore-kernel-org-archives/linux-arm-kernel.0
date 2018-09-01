From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 01 Sep 2018 16:08:45 +0200
Subject: [PATCH v3 03/13] fbdev: add kerneldoc do
 remove_conflicting_framebuffers()
In-Reply-To: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
Message-ID: <283fef19815b991700b56119d8d5874a2a8da44e.1535810304.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document remove_conflicting_framebuffers() behaviour.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 drivers/video/fbdev/core/fbmem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0df148eb4699..2de93b5014e3 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1775,6 +1775,16 @@ int unlink_framebuffer(struct fb_info *fb_info)
 }
 EXPORT_SYMBOL(unlink_framebuffer);
 
+/**
+ * remove_conflicting_framebuffers - remove firmware-configured framebuffers
+ * @a: memory range, users of which are to be removed
+ * @name: requesting driver name
+ * @primary: also kick vga16fb if present
+ *
+ * This function removes framebuffer devices (initialized by firmware/bootloader)
+ * which use memory range described by @a. If @a is NULL all such devices are
+ * removed.
+ */
 int remove_conflicting_framebuffers(struct apertures_struct *a,
 				    const char *name, bool primary)
 {
-- 
2.18.0
