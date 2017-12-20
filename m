From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 20 Dec 2017 10:52:34 +0100
Subject: [PATCH 2/2] pinctrl/nomadik/abx500: Improve a size determination in
 abx500_gpio_probe()
In-Reply-To: <e5be1da7-460d-a47d-59b8-c1902907f5a4@users.sourceforge.net>
References: <e5be1da7-460d-a47d-59b8-c1902907f5a4@users.sourceforge.net>
Message-ID: <93beb4d9-99e2-e7f2-e752-2d7228a8df46@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 20 Dec 2017 10:22:53 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index feb030d1ea63..7d00a5d864f5 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -1155,8 +1155,7 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	pct = devm_kzalloc(&pdev->dev, sizeof(struct abx500_pinctrl),
-				   GFP_KERNEL);
+	pct = devm_kzalloc(&pdev->dev, sizeof(*pct), GFP_KERNEL);
 	if (!pct)
 		return -ENOMEM;
 
-- 
2.15.1
