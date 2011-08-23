From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 23 Aug 2011 13:26:38 -0300
Subject: [PATCH] ARM: imx: pwm: Add support for MX53
Message-ID: <1314116798-12755-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of adding the check for MX53 CPU type, use the negative logic and let 
PWM to be configured for MX53 as well.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/pwm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 761c3c9..42d74ea 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -57,7 +57,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
 		return -EINVAL;
 
-	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
+	if (!(cpu_is_mx1() || cpu_is_mx21())) {
 		unsigned long long c;
 		unsigned long period_cycles, duty_cycles, prescale;
 		u32 cr;
-- 
1.7.1
