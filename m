From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 25 Feb 2017 15:42:15 +0800
Subject: [PATCH 2/3] pwm: sunxi: Add A64 support
In-Reply-To: <20170225074216.64868-1-icenowy@aosc.xyz>
References: <20170225074216.64868-1-icenowy@aosc.xyz>
Message-ID: <20170225074216.64868-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A64 PWM controller has same register layout as sun4i driver, so it works
by adding A64 specific data.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/pwm/pwm-sun4i.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1284ffa05921..ca3431e03fb8 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -290,6 +290,12 @@ static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.npwm = 1,
 };
 
+static const struct sun4i_pwm_data sun4i_pwm_data_a64 = {
+	.has_prescaler_bypass = true,
+	.has_rdy = true,
+	.npwm = 1,
+};
+
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-pwm",
@@ -307,6 +313,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 		.compatible = "allwinner,sun8i-h3-pwm",
 		.data = &sun4i_pwm_data_h3,
 	}, {
+		.compatible = "allwinner,sun50i-a64-pwm",
+		.data = &sun4i_pwm_data_a64,
+	}, {
 		/* sentinel */
 	},
 };
-- 
2.11.1
