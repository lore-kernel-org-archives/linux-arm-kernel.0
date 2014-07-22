From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:17 +0100
Subject: [PATCH 11/19] mfd: twl4030-irq: Fix style warnings relating to
 pr_warn() and sizeof()
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

WARNING: Prefer pr_warn(... to pr_warning(...
+               pr_warning("twl4030: I2C error %d reading PIH ISR\n", ret);

WARNING: sizeof buf should be sizeof(buf)
+       memset(buf, 0xff, sizeof buf);

WARNING: sizeof *agent should be sizeof(*agent)
+       agent = kzalloc(sizeof *agent, GFP_KERNEL);

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/twl4030-irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 596b1f6..b1dabba 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -297,7 +297,7 @@ static irqreturn_t handle_twl4030_pih(int irq, void *devid)
 	ret = twl_i2c_read_u8(TWL_MODULE_PIH, &pih_isr,
 			      REG_PIH_ISR_P1);
 	if (ret) {
-		pr_warning("twl4030: I2C error %d reading PIH ISR\n", ret);
+		pr_warn("twl4030: I2C error %d reading PIH ISR\n", ret);
 		return IRQ_NONE;
 	}
 
@@ -338,7 +338,7 @@ static int twl4030_init_sih_modules(unsigned line)
 	irq_line = line;
 
 	/* disable all interrupts on our line */
-	memset(buf, 0xff, sizeof buf);
+	memset(buf, 0xff, sizeof(buf));
 	sih = sih_modules;
 	for (i = 0; i < nr_sih_modules; i++, sih++) {
 		/* skip USB -- it's funky */
@@ -646,7 +646,7 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
 	if (status < 0)
 		return status;
 
-	agent = kzalloc(sizeof *agent, GFP_KERNEL);
+	agent = kzalloc(sizeof(*agent), GFP_KERNEL);
 	if (!agent)
 		return -ENOMEM;
 
-- 
1.8.3.2
