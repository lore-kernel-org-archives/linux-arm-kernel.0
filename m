From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 31 May 2016 11:36:15 +0200
Subject: [PATCH] pinctrl: oxnas: Rename pinctrl_utils_dt_free_map to
 pinctrl_utils_free_map
Message-ID: <1464687375-1370-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map, introduced in
d32f7fd3bbc3 ("pinctrl: Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map")
but not reported into oxnas driver.

Fixes: 611dac1e48a4 ("pinctrl: Add Oxford Semiconductor OXNAS pinctrl and gpio driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/pinctrl-oxnas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index 2c6abef..917a7d2 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -321,7 +321,7 @@ static const struct pinctrl_ops oxnas_pinctrl_ops = {
 	.get_group_name = oxnas_pinctrl_get_group_name,
 	.get_group_pins = oxnas_pinctrl_get_group_pins,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int oxnas_pinmux_get_functions_count(struct pinctrl_dev *pctldev)
-- 
1.9.1
