From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon,  1 Jan 2018 15:23:10 -0800
Subject: [PATCH v2 21/21] nvmem: bcm-ocotp: Do not use "&pdev->dev" explicitly
In-Reply-To: <20180101232310.30420-1-andrew.smirnov@gmail.com>
References: <20180101232310.30420-1-andrew.smirnov@gmail.com>
Message-ID: <20180101232310.30420-22-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's "dev" variable for this already. Use it.

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
 drivers/nvmem/bcm-ocotp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 24c30fa475cc..4159b3f41d79 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -262,8 +262,7 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 	else if (of_device_is_compatible(dev->of_node, "brcm,ocotp-v2"))
 		priv->map = &otp_map_v2;
 	else {
-		dev_err(&pdev->dev,
-			"%s otpc config map not defined\n", __func__);
+		dev_err(dev, "%s otpc config map not defined\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.14.3
