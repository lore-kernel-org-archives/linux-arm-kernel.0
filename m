From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed,  5 Jan 2011 05:05:07 +0300
Subject: [PATCH 3/6] pxa2xx: update stored gpio settings in
	pxa2xx_mfp_set_lpm()
In-Reply-To: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1294193110-23958-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa2xx_mfp_set_lpm() reconfigures MFP, but doesn't update gpio_desc cache. Fix that.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/mfp-pxa2xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index 1d1419b..7a6e122 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -160,6 +160,7 @@ void pxa2xx_mfp_set_lpm(int mfp, unsigned long lpm)
 
 	c = gpio_desc[gpio].config;
 	c = (c & ~MFP_LPM_STATE_MASK) | lpm;
+	gpio_desc[gpio].config = c;
 	__mfp_config_gpio(gpio, c);
 
 	local_irq_restore(flags);
-- 
1.7.2.3
