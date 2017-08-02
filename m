From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:43:04 +0800
Subject: [PATCH v2 12/23] i2c: rk3x: add support for rv1108
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501663384-12363-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for the i2c controller on rv1108 soc.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v2: None

 drivers/i2c/busses/i2c-rk3x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index df22066..fe23457 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -1131,6 +1131,11 @@ static const struct i2c_algorithm rk3x_i2c_algorithm = {
 	.functionality		= rk3x_i2c_func,
 };
 
+static const struct rk3x_i2c_soc_data rv1108_soc_data = {
+	.grf_offset = -1,
+	.calc_timings = rk3x_i2c_v1_calc_timings,
+};
+
 static const struct rk3x_i2c_soc_data rk3066_soc_data = {
 	.grf_offset = 0x154,
 	.calc_timings = rk3x_i2c_v0_calc_timings,
@@ -1158,6 +1163,10 @@ static const struct rk3x_i2c_soc_data rk3399_soc_data = {
 
 static const struct of_device_id rk3x_i2c_match[] = {
 	{
+		.compatible = "rockchip,rv1108-i2c",
+		.data = (void *)&rv1108_soc_data
+	},
+	{
 		.compatible = "rockchip,rk3066-i2c",
 		.data = (void *)&rk3066_soc_data
 	},
-- 
2.7.4
