From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 11:41:51 +0100
Subject: [PATCH 3/3] memory: da8xx-ddrctl: drop the call to
 of_flat_dt_get_machine_name()
In-Reply-To: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479811311-3080-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid a section mismatch use of_machine_get_compatible()
instead of of_flat_dt_get_machine_name() when printing the error
message.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/memory/da8xx-ddrctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index a20e7bb..179f505 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -118,7 +118,7 @@ static int da8xx_ddrctl_probe(struct platform_device *pdev)
 	setting = da8xx_ddrctl_get_board_settings();
 	if (!setting) {
 		dev_err(dev, "no settings for board '%s'\n",
-			of_flat_dt_get_machine_name());
+			of_machine_get_compatible());
 		return -EINVAL;
 	}
 
-- 
2.9.3
