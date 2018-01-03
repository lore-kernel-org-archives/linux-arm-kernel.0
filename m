From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  3 Jan 2018 12:01:13 -0800
Subject: [PATCH v3 21/22] nvmem: imx-iim: Do not use "&pdev->dev" explicitly
In-Reply-To: <20180103200114.23922-1-andrew.smirnov@gmail.com>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
Message-ID: <20180103200114.23922-22-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's already "dev" variable for that. Use it.

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
 drivers/nvmem/imx-iim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index 635561a441bd..3022bd96bd7e 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -125,7 +125,7 @@ static int imx_iim_probe(struct platform_device *pdev)
 
 	drvdata = of_id->data;
 
-	iim->clk = devm_clk_get(&pdev->dev, NULL);
+	iim->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(iim->clk))
 		return PTR_ERR(iim->clk);
 
-- 
2.14.3
