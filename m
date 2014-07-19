From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 20 Jul 2014 01:48:45 +0200
Subject: [PATCH 1/3] pinctrl: rockchip: set is_generic in pinconf_ops
Message-ID: <3086962.49c4Dnm508@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rockchip pinctrl driver implements the generic pinconfig, therefore
also state this, so that the default pinconf dump functions work.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 169c3db..37339a1 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -946,6 +946,7 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 static const struct pinconf_ops rockchip_pinconf_ops = {
 	.pin_config_get			= rockchip_pinconf_get,
 	.pin_config_set			= rockchip_pinconf_set,
+	.is_generic			= true,
 };
 
 static const struct of_device_id rockchip_bank_match[] = {
-- 
1.9.0
