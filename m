From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 23 Nov 2016 14:40:00 +0100
Subject: [PATCH v4 2/2] memory: da8xx-ddrctl: drop the call to
 of_flat_dt_get_machine_name()
In-Reply-To: <1479908400-10136-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479908400-10136-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479908400-10136-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid a section mismatch drop the call to
of_flat_dt_get_machine_name() when printing the error message.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/memory/da8xx-ddrctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index a20e7bb..030afbe 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_fdt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
@@ -117,8 +116,7 @@ static int da8xx_ddrctl_probe(struct platform_device *pdev)
 
 	setting = da8xx_ddrctl_get_board_settings();
 	if (!setting) {
-		dev_err(dev, "no settings for board '%s'\n",
-			of_flat_dt_get_machine_name());
+		dev_err(dev, "no settings defined for this board\n");
 		return -EINVAL;
 	}
 
-- 
2.9.3
