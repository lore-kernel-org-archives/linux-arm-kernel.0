From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 22 May 2010 00:44:49 +0300
Subject: [PATCH v2t2 17/17] omap: mailbox: don't export register/unregister
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1274478289-22188-18-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need for that now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    3 ---
 arch/arm/plat-omap/mailbox.c              |    6 ++----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index cbde52a..e01be54 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -78,9 +78,6 @@ void omap_mbox_init_seq(struct omap_mbox *);
 struct omap_mbox *omap_mbox_get(const char *);
 void omap_mbox_put(struct omap_mbox *);
 
-int omap_mbox_register(struct device *parent, struct omap_mbox *);
-int omap_mbox_unregister(struct omap_mbox *);
-
 static inline void omap_mbox_save_ctx(struct omap_mbox *mbox)
 {
 	if (!mbox->ops->save_ctx) {
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index a784284..69267a2 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -349,7 +349,7 @@ EXPORT_SYMBOL(omap_mbox_put);
 
 static struct class omap_mbox_class = { .name = "mbox", };
 
-int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
+static int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 {
 	int ret = 0;
 	struct omap_mbox **tmp;
@@ -379,9 +379,8 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 err_find:
 	return ret;
 }
-EXPORT_SYMBOL(omap_mbox_register);
 
-int omap_mbox_unregister(struct omap_mbox *mbox)
+static int omap_mbox_unregister(struct omap_mbox *mbox)
 {
 	struct omap_mbox **tmp;
 
@@ -401,7 +400,6 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL(omap_mbox_unregister);
 
 static int __devinit omap_mbox_probe(struct platform_device *pdev)
 {
-- 
1.7.1
