From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:17:30 +0800
Subject: [PATCH 4/6] ARM: mxs: remove cpu_is_mx23() call from timer code
In-Reply-To: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
References: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364224652-28332-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove cpu_is_mx23() call from timer code by using
of_device_is_compatible() instead.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/timer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index c8cda18..f4dd96ff 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -266,7 +266,8 @@ static void __init mxs_timer_init(struct device_node *np)
 
 	/* get timrot version */
 	timrot_major_version = __raw_readl(mxs_timrot_base +
-				(cpu_is_mx23() ? MX23_TIMROT_VERSION_OFFSET :
+			(of_device_is_compatible(np, "fsl,imx23-timrot") ?
+						MX23_TIMROT_VERSION_OFFSET :
 						MX28_TIMROT_VERSION_OFFSET));
 	timrot_major_version >>= BP_TIMROT_MAJOR_VERSION;
 
-- 
1.7.9.5
