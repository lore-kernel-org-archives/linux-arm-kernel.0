From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 19 Mar 2018 16:33:11 +0100
Subject: [PATCH v2 1/4] memory: aemif: don't rely on kbuild for driver's name
In-Reply-To: <20180319153314.26120-1-brgl@bgdev.pl>
References: <20180319153314.26120-1-brgl@bgdev.pl>
Message-ID: <20180319153314.26120-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to use aemif from board files. Use a static name in the
driver's code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/memory/ti-aemif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 2744b1b91b57..588e58d40d1b 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -422,7 +422,7 @@ static struct platform_driver aemif_driver = {
 	.probe = aemif_probe,
 	.remove = aemif_remove,
 	.driver = {
-		.name = KBUILD_MODNAME,
+		.name = "ti-aemif",
 		.of_match_table = of_match_ptr(aemif_of_match),
 	},
 };
-- 
2.16.1
