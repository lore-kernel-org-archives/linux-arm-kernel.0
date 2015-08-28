From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri, 28 Aug 2015 13:46:47 +0800
Subject: [PATCH v1 2/3] pinctrl: rockchip: add support for the rk3036
In-Reply-To: <1440740808-15004-1-git-send-email-zhengxing@rock-chips.com>
References: <1440740808-15004-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1440740808-15004-3-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many parts of pinctrl rk3036 are similar to rk2928's.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v1: None

 drivers/pinctrl/pinctrl-rockchip.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index cc2843a..d06631d 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2042,6 +2042,21 @@ static struct rockchip_pin_ctrl rk2928_pin_ctrl = {
 		.pull_calc_reg		= rk2928_calc_pull_reg_and_bit,
 };
 
+static struct rockchip_pin_bank rk3036_pin_banks[] = {
+	PIN_BANK(0, 32, "gpio0"),
+	PIN_BANK(1, 32, "gpio1"),
+	PIN_BANK(2, 32, "gpio2"),
+};
+
+static struct rockchip_pin_ctrl rk3036_pin_ctrl = {
+		.pin_banks		= rk3036_pin_banks,
+		.nr_banks		= ARRAY_SIZE(rk3036_pin_banks),
+		.label			= "RK3036-GPIO",
+		.type			= RK2928,
+		.grf_mux_offset		= 0xa8,
+		.pull_calc_reg		= rk2928_calc_pull_reg_and_bit,
+};
+
 static struct rockchip_pin_bank rk3066a_pin_banks[] = {
 	PIN_BANK(0, 32, "gpio0"),
 	PIN_BANK(1, 32, "gpio1"),
@@ -2160,6 +2175,8 @@ static struct rockchip_pin_ctrl rk3368_pin_ctrl = {
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
 	{ .compatible = "rockchip,rk2928-pinctrl",
 		.data = (void *)&rk2928_pin_ctrl },
+	{ .compatible = "rockchip,rk3036-pinctrl",
+		.data = (void *)&rk3036_pin_ctrl },
 	{ .compatible = "rockchip,rk3066a-pinctrl",
 		.data = (void *)&rk3066a_pin_ctrl },
 	{ .compatible = "rockchip,rk3066b-pinctrl",
-- 
1.7.9.5
