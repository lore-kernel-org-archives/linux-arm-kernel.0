From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 10 Apr 2011 21:49:03 +0200
Subject: [PATCH 6/6] ARM: imx: remove some deprecated and unused #defines
In-Reply-To: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1302464943-20721-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mxc.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 0aba8b1..4ac53ce 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -194,13 +194,6 @@ enum mxc_cpu_pwr_mode {
 extern struct cpu_op *(*get_cpu_op)(int *op);
 #endif
 
-#if defined(CONFIG_ARCH_MX3) || defined(CONFIG_ARCH_MX2)
-/* These are deprecated, use mx[23][157]_setup_weimcs instead. */
-#define CSCR_U(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10))
-#define CSCR_L(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10 + 0x4))
-#define CSCR_A(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10 + 0x8))
-#endif
-
 #define cpu_is_mx3()	(cpu_is_mx31() || cpu_is_mx35())
 #define cpu_is_mx2()	(cpu_is_mx21() || cpu_is_mx27())
 
-- 
1.7.2.3
