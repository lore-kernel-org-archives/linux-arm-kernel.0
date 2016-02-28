From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:37:00 +0000
Subject: [PATCH v5 09/20] clk: bcm2835: enable management of PCM clock
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-10-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Enable the PCM clock in the SOC, which is used by the
bcm2835-i2s driver.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |    6 ++++++
 include/dt-bindings/clock/bcm2835.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index ffc5b3c..3df17a5 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1507,6 +1507,12 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.div_reg = CM_HSMDIV,
 		.int_bits = 4,
 		.frac_bits = 8),
+	[BCM2835_CLOCK_PCM]	= REGISTER_PER_CLK(
+		.name = "pcm",
+		.ctl_reg = CM_PCMCTL,
+		.div_reg = CM_PCMDIV,
+		.int_bits = 12,
+		.frac_bits = 12),
 	[BCM2835_CLOCK_PWM]	= REGISTER_PER_CLK(
 		.name = "pwm",
 		.ctl_reg = CM_PWMCTL,
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 87235ac..9a7b4a5 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -44,3 +44,4 @@
 #define BCM2835_CLOCK_EMMC		28
 #define BCM2835_CLOCK_PERI_IMAGE	29
 #define BCM2835_CLOCK_PWM		30
+#define BCM2835_CLOCK_PCM		31
-- 
1.7.10.4
