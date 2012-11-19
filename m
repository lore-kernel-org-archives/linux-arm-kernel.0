From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:25:52 -0500
Subject: [PATCH 403/493] hwspinlock: remove use of __devexit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-403-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Ohad Ben-Cohen <ohad@wizery.com> 
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: linux-omap at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org 
---
 drivers/hwspinlock/omap_hwspinlock.c | 2 +-
 drivers/hwspinlock/u8500_hsem.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index f21b2ed..292869c 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -142,7 +142,7 @@ iounmap_base:
 	return ret;
 }
 
-static int __devexit omap_hwspinlock_remove(struct platform_device *pdev)
+static int omap_hwspinlock_remove(struct platform_device *pdev)
 {
 	struct hwspinlock_device *bank = platform_get_drvdata(pdev);
 	void __iomem *io_base = bank->lock[0].priv - LOCK_BASE_OFFSET;
diff --git a/drivers/hwspinlock/u8500_hsem.c b/drivers/hwspinlock/u8500_hsem.c
index 5a5b3f2..401c33b 100644
--- a/drivers/hwspinlock/u8500_hsem.c
+++ b/drivers/hwspinlock/u8500_hsem.c
@@ -148,7 +148,7 @@ iounmap_base:
 	return ret;
 }
 
-static int __devexit u8500_hsem_remove(struct platform_device *pdev)
+static int u8500_hsem_remove(struct platform_device *pdev)
 {
 	struct hwspinlock_device *bank = platform_get_drvdata(pdev);
 	void __iomem *io_base = bank->lock[0].priv - HSEM_REGISTER_OFFSET;
-- 
1.8.0
