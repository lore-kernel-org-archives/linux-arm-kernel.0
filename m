From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 18 Sep 2013 17:06:05 +0200
Subject: [PATCH 1/2] pwm: atmel-tcb: add missing clk source config
In-Reply-To: <1379516720-23289-1-git-send-email-b.brezillon@overkiz.com>
References: <1379516720-23289-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1379516765-23342-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock source changes are never applied to the CMR register.
This may lead to wrong period/duty cycle configuration.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/pwm/pwm-atmel-tcb.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index ba6ce01..0266969 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -249,6 +249,8 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		}
 	}
 
+	cmr |= (tcbpwm->div & ATMEL_TC_TCCLKS);
+
 	__raw_writel(cmr, regs + ATMEL_TC_REG(group, CMR));
 
 	if (index == 0)
-- 
1.7.9.5
