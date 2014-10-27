From: romain.perier@gmail.com (Romain Perier)
Date: Mon, 27 Oct 2014 16:26:48 +0000
Subject: [PATCH v1 03/10] regulator: act8865: Use
 of_is_system_power_controller helper function
In-Reply-To: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1414427215-14380-3-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/regulator/act8865-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 76301ed..435aba1 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -365,7 +365,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (of_system_has_poweroff_source(dev->of_node)) {
+	if (of_is_system_power_controller(dev->of_node)) {
 		if (!pm_power_off) {
 			act8865_i2c_client = client;
 			act8865->off_reg = off_reg;
-- 
1.9.1
