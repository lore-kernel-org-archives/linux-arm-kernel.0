From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 15 Nov 2011 14:47:59 +0800
Subject: [PATCH V4 04/14] ARM: mxc: pwm: add clk_prepare/clk_unprepare
In-Reply-To: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
References: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1321339689-25256-5-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's for migrating to generic clk framework API.

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
