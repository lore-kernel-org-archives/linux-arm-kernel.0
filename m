From: rrajk@nvidia.com (Rajkumar Rampelli)
Date: Wed, 21 Feb 2018 12:28:50 +0530
Subject: [PATCH 01/10] pwm: core: Add support for PWM HW driver with pwm
 capture only
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
Message-ID: <1519196339-9377-2-git-send-email-rrajk@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for pwm HW driver which has only capture functionality.
This helps to implement the PWM based Tachometer driver which reads
the PWM output signals from electronic fans.

PWM Tachometer captures the period and duty cycle of the PWM signal

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 drivers/pwm/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6a..87d14c9 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -246,6 +246,10 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
 	if (ops->apply)
 		return true;
 
+	/* driver supports capture operation */
+	if (ops->capture)
+		return true;
+
 	return false;
 }
 
-- 
2.1.4
