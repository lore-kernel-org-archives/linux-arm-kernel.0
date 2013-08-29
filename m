From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Aug 2013 12:21:01 +0100
Subject: [PATCH] clk: wm831x: Initialise wm831x pointer on init
Message-ID: <1377775261-3190-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Otherwise any attempt to interact with the hardware will crash. This is
what happens when drivers get written blind.

Signed-off-by: Mark Brown <broonie@linaro.org>
Cc: stable at vger.kernel.org
---
 drivers/clk/clk-wm831x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index 1b3f8c9..1d5af3f 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -360,6 +360,8 @@ static int wm831x_clk_probe(struct platform_device *pdev)
 	if (!clkdata)
 		return -ENOMEM;
 
+	clkdata->wm831x = wm831x;
+
 	/* XTAL_ENA can only be set via OTP/InstantConfig so just read once */
 	ret = wm831x_reg_read(wm831x, WM831X_CLOCK_CONTROL_2);
 	if (ret < 0) {
-- 
1.8.4.rc3
