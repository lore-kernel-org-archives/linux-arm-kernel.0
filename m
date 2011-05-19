From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 18:47:22 +0200
Subject: [PATCH 2/8] ARM i.MX: define CLOCK_TICK_RATE to bogus value
In-Reply-To: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305823648-2428-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a clocksource which renders CLOCK_TICK_RATE useless. Define
it to a bogus value to get rid of some ifdeffery.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/timex.h |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/timex.h b/arch/arm/plat-mxc/include/mach/timex.h
index d61d5c7..10343d1 100644
--- a/arch/arm/plat-mxc/include/mach/timex.h
+++ b/arch/arm/plat-mxc/include/mach/timex.h
@@ -16,16 +16,7 @@
 #ifndef __ASM_ARCH_MXC_TIMEX_H__
 #define __ASM_ARCH_MXC_TIMEX_H__
 
-#if defined CONFIG_ARCH_MX1
-#define CLOCK_TICK_RATE		16000000
-#elif defined CONFIG_ARCH_MX2
-#define CLOCK_TICK_RATE		13300000
-#elif defined CONFIG_ARCH_MX3
-#define CLOCK_TICK_RATE		16625000
-#elif defined CONFIG_ARCH_MX25
-#define CLOCK_TICK_RATE		16000000
-#elif defined CONFIG_ARCH_MX5
-#define CLOCK_TICK_RATE		8000000
-#endif
+/* Bogus value */
+#define CLOCK_TICK_RATE	12345678
 
 #endif				/* __ASM_ARCH_MXC_TIMEX_H__ */
-- 
1.7.4.1
