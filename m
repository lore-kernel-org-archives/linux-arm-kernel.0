From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 21 Sep 2018 09:29:06 +0200
Subject: [PATCH v5 07/22] nvmem: sunxi_sid: return -ENOMEM if kzalloc() fails
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
Message-ID: <20180921072921.19387-8-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The driver currently returns -EINVAL if kzalloc() fails in probe().
Change it to -ENOMEM as it should be.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/sunxi_sid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index d020f89248fd..4d0b7e72aa2e 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -187,7 +187,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 
 	randomness = kzalloc(size, GFP_KERNEL);
 	if (!randomness) {
-		ret = -EINVAL;
+		ret = -ENOMEM;
 		goto err_unreg_nvmem;
 	}
 
-- 
2.18.0
