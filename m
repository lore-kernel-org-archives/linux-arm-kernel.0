From: jason.hui@linaro.org (Jason Liu)
Date: Wed, 24 Aug 2011 20:45:41 +0800
Subject: [PATCH] ARM: i.MX: initialize l2x0 at early_init time
Message-ID: <1314189941-16406-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can make the l2 cache work at early time which
will benefit the boot up time.

Tested on i.mx31pdk board, test result shows:
Before:
[    0.555716] console [ttymxc0] enabled

After:
[    0.558755] console [ttymxc0] enabled

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/cache-l2x0.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/cache-l2x0.c b/arch/arm/mach-imx/cache-l2x0.c
index 69d1322..e5538a4 100644
--- a/arch/arm/mach-imx/cache-l2x0.c
+++ b/arch/arm/mach-imx/cache-l2x0.c
@@ -53,4 +53,4 @@ static int mxc_init_l2x0(void)
 
 	return 0;
 }
-arch_initcall(mxc_init_l2x0);
+early_initcall(mxc_init_l2x0);
-- 
1.7.4.1
