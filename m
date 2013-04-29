From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 29 Apr 2013 14:32:01 +0900
Subject: [PATCH] module: fix mutiple defined issue
Message-ID: <1367213521-26795-1-git-send-email-inki.dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes mutiple defined issue to MODULE_DEVICE_TABLE

The issue could be induced when some framework which includes two
more sub drivers, is built as one moudle because those sub drivers
could have their own MODULE_DEVICE_TABLE.

And 'struct of_device_id' isn't needed to be determined by type
argument because the definition of 'of_device_id' should be fixed.
So this patch makes 'of_devce_id' definition to be fixed and
only its instance name to be defined by type.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
---
 include/linux/module.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 46f1ea0..ac5d79f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -84,7 +84,7 @@ void trim_init_extable(struct module *m);
 
 #ifdef MODULE
 #define MODULE_GENERIC_TABLE(gtype,name)			\
-extern const struct gtype##_id __mod_##gtype##_table		\
+extern const struct of_device_id __mod_##gtype##_table		\
   __attribute__ ((unused, alias(__stringify(name))))
 
 #else  /* !MODULE */
-- 
1.7.5.4
