From: b.galvani@gmail.com (Beniamino Galvani)
Date: Mon, 24 Mar 2014 23:36:01 +0100
Subject: [PATCH] pinctrl: rockchip: fix offset of mux registers for rk3188
Message-ID: <1395700561-3793-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct value of .mux_offset for rk3188 seems to be 0x60
instead of 0x68.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/pinctrl/pinctrl-rockchip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 46dddc1..23e8812 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1534,7 +1534,7 @@ static struct rockchip_pin_ctrl rk3188_pin_ctrl = {
 		.nr_banks		= ARRAY_SIZE(rk3188_pin_banks),
 		.label			= "RK3188-GPIO",
 		.type			= RK3188,
-		.mux_offset		= 0x68,
+		.mux_offset		= 0x60,
 		.pull_calc_reg		= rk3188_calc_pull_reg_and_bit,
 };
 
-- 
1.7.10.4
