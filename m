From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 11 Nov 2011 18:50:27 +0800
Subject: [PATCH V3 04/14] ARM: mxc: pwm: add clk_prepare/clk_unprepare
In-Reply-To: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
References: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1321008637-19999-5-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/pwm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 42d74ea..68c7199b 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -118,7 +118,7 @@ int pwm_enable(struct pwm_device *pwm)
 	int rc = 0;
 
 	if (!pwm->clk_enabled) {
-		rc = clk_enable(pwm->clk);
+		rc = clk_prepare_enable(pwm->clk);
 		if (!rc)
 			pwm->clk_enabled = 1;
 	}
@@ -131,7 +131,7 @@ void pwm_disable(struct pwm_device *pwm)
 	writel(0, pwm->mmio_base + MX3_PWMCR);
 
 	if (pwm->clk_enabled) {
-		clk_disable(pwm->clk);
+		clk_disable_unprepare(pwm->clk);
 		pwm->clk_enabled = 0;
 	}
 }
-- 
1.7.5.4
