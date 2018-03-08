From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  8 Mar 2018 23:00:09 +0800
Subject: [PATCH 1/4] ARM: sunxi: mc-smp: Fix "lookback" typo
In-Reply-To: <20180308150012.19045-1-wens@csie.org>
References: <20180308150012.19045-1-wens@csie.org>
Message-ID: <20180308150012.19045-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi_mc_smp_lookback function is modeled after the mcpm_loopback
function in the MCPM framework. "lookback" was a typo introduced when
the new function was added.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/mc_smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 11e46c6efb90..9db6c4ed5861 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -659,7 +659,7 @@ static int __init nocache_trampoline(unsigned long __unused)
 	BUG();
 }
 
-static int __init sunxi_mc_smp_lookback(void)
+static int __init sunxi_mc_smp_loopback(void)
 {
 	int ret;
 
@@ -749,7 +749,7 @@ static int __init sunxi_mc_smp_init(void)
 	}
 
 	/* Configure CCI-400 for boot cluster */
-	ret = sunxi_mc_smp_lookback();
+	ret = sunxi_mc_smp_loopback();
 	if (ret) {
 		pr_err("%s: failed to configure boot cluster: %d\n",
 		       __func__, ret);
-- 
2.16.2
