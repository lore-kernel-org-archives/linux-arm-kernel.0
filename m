From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  3 Jan 2018 12:01:11 -0800
Subject: [PATCH v3 19/22] nvmem: vf610-ocotp: Do not use "&pdev->dev"
 explicitly
In-Reply-To: <20180103200114.23922-1-andrew.smirnov@gmail.com>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
Message-ID: <20180103200114.23922-20-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There already a "dev" variable for that. Use it.

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
 drivers/nvmem/vf610-ocotp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
index 752a0983e7fb..6e6bf7987d9d 100644
--- a/drivers/nvmem/vf610-ocotp.c
+++ b/drivers/nvmem/vf610-ocotp.c
@@ -223,8 +223,7 @@ static int vf610_ocotp_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct vf610_ocotp *ocotp_dev;
 
-	ocotp_dev = devm_kzalloc(&pdev->dev,
-			sizeof(struct vf610_ocotp), GFP_KERNEL);
+	ocotp_dev = devm_kzalloc(dev, sizeof(struct vf610_ocotp), GFP_KERNEL);
 	if (!ocotp_dev)
 		return -ENOMEM;
 
-- 
2.14.3
