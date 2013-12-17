From: balbi@ti.com (Felipe Balbi)
Date: Mon, 16 Dec 2013 18:08:15 -0600
Subject: [PATCH 01/10] mfd: menelaus: Drop __exit section annotation
In-Reply-To: <20131216153936.GQ18769@lee--X1>
References: <20131216153936.GQ18769@lee--X1>
Message-ID: <1387238904-7843-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We could build that driver as a dynamically-linked module.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/menelaus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index ad25bfa..975ff9e 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1262,7 +1262,7 @@ fail:
 	return err;
 }
 
-static int __exit menelaus_remove(struct i2c_client *client)
+static int menelaus_remove(struct i2c_client *client)
 {
 	struct menelaus_chip	*menelaus = i2c_get_clientdata(client);
 
@@ -1283,7 +1283,7 @@ static struct i2c_driver menelaus_i2c_driver = {
 		.name		= DRIVER_NAME,
 	},
 	.probe		= menelaus_probe,
-	.remove		= __exit_p(menelaus_remove),
+	.remove		= menelaus_remove,
 	.id_table	= menelaus_id,
 };
 
-- 
1.8.4.GIT
