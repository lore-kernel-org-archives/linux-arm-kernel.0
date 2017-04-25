From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 26 Apr 2017 06:34:22 +0900
Subject: [PATCH 1/2] pinctrl: rockchip: remove unneeded (void *) casts in
 of_match_table
In-Reply-To: <1493156063-8446-1-git-send-email-yamada.masahiro@socionext.com>
References: <1493156063-8446-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1493156063-8446-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id::data is an opaque pointer.  No explicit cast is needed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/pinctrl-rockchip.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 7813599..da1a38f 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2769,25 +2769,25 @@ static struct rockchip_pin_ctrl rk3399_pin_ctrl = {
 
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
 	{ .compatible = "rockchip,rk1108-pinctrl",
-		.data = (void *)&rk1108_pin_ctrl },
+		.data = &rk1108_pin_ctrl },
 	{ .compatible = "rockchip,rk2928-pinctrl",
-		.data = (void *)&rk2928_pin_ctrl },
+		.data = &rk2928_pin_ctrl },
 	{ .compatible = "rockchip,rk3036-pinctrl",
-		.data = (void *)&rk3036_pin_ctrl },
+		.data = &rk3036_pin_ctrl },
 	{ .compatible = "rockchip,rk3066a-pinctrl",
-		.data = (void *)&rk3066a_pin_ctrl },
+		.data = &rk3066a_pin_ctrl },
 	{ .compatible = "rockchip,rk3066b-pinctrl",
-		.data = (void *)&rk3066b_pin_ctrl },
+		.data = &rk3066b_pin_ctrl },
 	{ .compatible = "rockchip,rk3188-pinctrl",
-		.data = (void *)&rk3188_pin_ctrl },
+		.data = &rk3188_pin_ctrl },
 	{ .compatible = "rockchip,rk3228-pinctrl",
-		.data = (void *)&rk3228_pin_ctrl },
+		.data = &rk3228_pin_ctrl },
 	{ .compatible = "rockchip,rk3288-pinctrl",
-		.data = (void *)&rk3288_pin_ctrl },
+		.data = &rk3288_pin_ctrl },
 	{ .compatible = "rockchip,rk3368-pinctrl",
-		.data = (void *)&rk3368_pin_ctrl },
+		.data = &rk3368_pin_ctrl },
 	{ .compatible = "rockchip,rk3399-pinctrl",
-		.data = (void *)&rk3399_pin_ctrl },
+		.data = &rk3399_pin_ctrl },
 	{},
 };
 
-- 
2.7.4
