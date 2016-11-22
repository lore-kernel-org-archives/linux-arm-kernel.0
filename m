From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 11:41:50 +0100
Subject: [PATCH 2/3] bus: da8xx-mstpri: drop the call to
 of_flat_dt_get_machine_name()
In-Reply-To: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479811311-3080-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid a section mismatch use of_machine_get_compatible()
instead of of_flat_dt_get_machine_name() when printing the error
message.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/bus/da8xx-mstpri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
index 85f0b53..41cbbe6 100644
--- a/drivers/bus/da8xx-mstpri.c
+++ b/drivers/bus/da8xx-mstpri.c
@@ -227,7 +227,7 @@ static int da8xx_mstpri_probe(struct platform_device *pdev)
 	prio_list = da8xx_mstpri_get_board_prio();
 	if (!prio_list) {
 		dev_err(dev, "no master priotities defined for board '%s'\n",
-			of_flat_dt_get_machine_name());
+			of_machine_get_compatible());
 		return -EINVAL;
 	}
 
-- 
2.9.3
