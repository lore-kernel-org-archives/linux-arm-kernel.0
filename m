From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 19 Jun 2013 23:54:36 +0400
Subject: [PATCH v2 5/7] drivers: bus: imx-weim: Add missing
 platform_friver.owner field
In-Reply-To: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
References: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
Message-ID: <1371671678-6345-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/bus/imx-weim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index b558aa3..b6479fb 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -120,8 +120,9 @@ static int __init weim_probe(struct platform_device *pdev)
 
 static struct platform_driver weim_driver = {
 	.driver = {
-		.name = "imx-weim",
-		.of_match_table = weim_id_table,
+		.name		= "imx-weim",
+		.owner		= THIS_MODULE,
+		.of_match_table	= weim_id_table,
 	},
 };
 module_platform_driver_probe(weim_driver, weim_probe);
-- 
1.8.1.5
