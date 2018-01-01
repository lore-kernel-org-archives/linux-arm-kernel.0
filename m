From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon,  1 Jan 2018 15:23:05 -0800
Subject: [PATCH v2 16/21] nvmem: snvs_lpgpr: Convert commas to semicolons
In-Reply-To: <20180101232310.30420-1-andrew.smirnov@gmail.com>
References: <20180101232310.30420-1-andrew.smirnov@gmail.com>
Message-ID: <20180101232310.30420-17-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like commas were accidentally used where semicolons were
supposed to be. Fix that.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy at gmail.com
Cc: linux-kernel at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/snvs_lpgpr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index 6a2fdd09e74a..90aaf818563b 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -110,12 +110,12 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	cfg->priv = priv;
 	cfg->name = dev_name(dev);
 	cfg->dev = dev;
-	cfg->stride = 4,
-	cfg->word_size = 4,
-	cfg->size = 4,
-	cfg->owner = THIS_MODULE,
-	cfg->reg_read  = snvs_lpgpr_read,
-	cfg->reg_write = snvs_lpgpr_write,
+	cfg->stride = 4;
+	cfg->word_size = 4;
+	cfg->size = 4;
+	cfg->owner = THIS_MODULE;
+	cfg->reg_read  = snvs_lpgpr_read;
+	cfg->reg_write = snvs_lpgpr_write;
 
 	nvmem = devm_nvmem_register(dev, cfg);
 	if (IS_ERR(nvmem))
-- 
2.14.3
