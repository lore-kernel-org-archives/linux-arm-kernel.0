From: jason.hui@linaro.org (Jason Liu)
Date: Wed, 2 Nov 2011 19:03:55 +0800
Subject: [PATCH v3 2/3] ARM:i.MX: fix the build error in clock-mx51-mx53.c
In-Reply-To: <1320231836-9555-1-git-send-email-jason.hui@linaro.org>
References: <1320231836-9555-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1320231836-9555-5-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mx5/clock-mx51-mx53.c: In function 'clk_get_freq_dt':
arch/arm/mach-mx5/clock-mx51-mx53.c:1643: error: implicit declaration of function 'for_each_compatible_node'
arch/arm/mach-mx5/clock-mx51-mx53.c:1643: error: expected ';' before '{' token

Signed-off-by: Jason Liu <jason.hui@linaro.org>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 2aacf41..7c373b83 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1637,6 +1637,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 static void __init clk_get_freq_dt(unsigned long *ckil, unsigned long *osc,
 				   unsigned long *ckih1, unsigned long *ckih2)
 {
+#ifdef CONFIG_OF
 	struct device_node *np;
 
 	/* retrieve the freqency of fixed clocks from device tree */
@@ -1654,6 +1655,7 @@ static void __init clk_get_freq_dt(unsigned long *ckil, unsigned long *osc,
 		else if (of_device_is_compatible(np, "fsl,imx-ckih2"))
 			*ckih2 = rate;
 	}
+#endif
 }
 
 int __init mx51_clocks_init_dt(void)
-- 
1.7.4.1
