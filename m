From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Mon, 26 Oct 2015 22:32:33 +0100
Subject: [PATCH 02/10] pwm: sunxi: fix whitespace issue
In-Reply-To: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1445895161-2317-3-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

This patch changes no code, it just fixes the whitespacing

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/pwm/pwm-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5ec4e8e..58ff424 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -115,7 +115,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * is not an integer so round it half up instead of
 		 * truncating to get less surprising values.
 		 */
-		div = clk_rate * period_ns + NSEC_PER_SEC/2;
+		div = clk_rate * period_ns + NSEC_PER_SEC / 2;
 		do_div(div, NSEC_PER_SEC);
 		if (div - 1 > PWM_PRD_MASK)
 			prescaler = 0;
-- 
2.6.1
