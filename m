From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 14 May 2012 19:06:36 +0800
Subject: [PATCH 1/5] pinctrl: a minor error checking improvement for pinconf
Message-ID: <1336993600-30065-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Also checking invalid num_configs when validate the pinconf map.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinconf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index 7ce139e..43f474c 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -50,9 +50,9 @@ int pinconf_validate_map(struct pinctrl_map const *map, int i)
 		return -EINVAL;
 	}
 
-	if (map->data.configs.num_configs &&
+	if (!map->data.configs.num_configs ||
 			!map->data.configs.configs) {
-		pr_err("failed to register map %s (%d): no configs ptr given\n",
+		pr_err("failed to register map %s (%d): no configs given\n",
 		       map->name, i);
 		return -EINVAL;
 	}
-- 
1.7.0.4
