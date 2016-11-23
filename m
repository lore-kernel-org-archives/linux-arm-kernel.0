From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 23 Nov 2016 14:39:59 +0100
Subject: [PATCH v4 1/2] bus: da8xx-mstpri: drop the call to
 of_flat_dt_get_machine_name()
In-Reply-To: <1479908400-10136-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479908400-10136-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479908400-10136-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid a section mismatch drop the call to
of_flat_dt_get_machine_name() when printing the error message.

While we're at it: fix a typo.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/bus/da8xx-mstpri.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
index 85f0b53..063397f 100644
--- a/drivers/bus/da8xx-mstpri.c
+++ b/drivers/bus/da8xx-mstpri.c
@@ -16,7 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/regmap.h>
-#include <linux/of_fdt.h>
 
 /*
  * REVISIT: Linux doesn't have a good framework for the kind of performance
@@ -226,8 +225,7 @@ static int da8xx_mstpri_probe(struct platform_device *pdev)
 
 	prio_list = da8xx_mstpri_get_board_prio();
 	if (!prio_list) {
-		dev_err(dev, "no master priotities defined for board '%s'\n",
-			of_flat_dt_get_machine_name());
+		dev_err(dev, "no master priorities defined for this board\n");
 		return -EINVAL;
 	}
 
-- 
2.9.3
