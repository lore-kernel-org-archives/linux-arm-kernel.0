From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 18 Mar 2016 17:47:36 +0100
Subject: [PATCH v2 4/9] efi: efifb: use builtin_platform_driver and drop
 unused includes
In-Reply-To: <1458319661-19762-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1458319661-19762-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1458319661-19762-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since efifb can only be built directly into the kernel, drop the module
specific includes and definitions. Drop some other includes we don't need
as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/video/fbdev/efifb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index dd594369b8a6..f4c045c0051c 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -6,15 +6,12 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/errno.h>
 #include <linux/fb.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
-#include <linux/dmi.h>
-#include <linux/pci.h>
 #include <video/vga.h>
 #include <asm/efi.h>
 
@@ -331,5 +328,4 @@ static struct platform_driver efifb_driver = {
 	.remove = efifb_remove,
 };
 
-module_platform_driver(efifb_driver);
-MODULE_LICENSE("GPL");
+builtin_platform_driver(efifb_driver);
-- 
2.5.0
