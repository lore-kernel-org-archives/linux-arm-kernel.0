From: jason.hui@linaro.org (Jason Liu)
Date: Thu, 3 Nov 2011 17:31:27 +0800
Subject: [PATCH v2 2/2] ARM:i.MX: fix build error in clock-mx51-mx53.c
In-Reply-To: <1320312687-20987-1-git-send-email-jason.hui@linaro.org>
References: <1320312687-20987-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1320312687-20987-3-git-send-email-jason.hui@linaro.org>
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
index 2aacf41..6312425 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1634,6 +1634,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static void __init clk_get_freq_dt(unsigned long *ckil, unsigned long *osc,
 				   unsigned long *ckih1, unsigned long *ckih2)
 {
@@ -1671,3 +1672,4 @@ int __init mx53_clocks_init_dt(void)
 	clk_get_freq_dt(&ckil, &osc, &ckih1, &ckih2);
 	return mx53_clocks_init(ckil, osc, ckih1, ckih2);
 }
+#endif
-- 
1.7.4.1
