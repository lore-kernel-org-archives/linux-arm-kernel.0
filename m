From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 27 Nov 2013 11:00:58 +0100
Subject: [PATCH 5/4 v2] ARM: at91: don't use <mach/timex.h>
In-Reply-To: <1385474690-6483-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1385474690-6483-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1385546458-12122-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform specific <mach/timex.h> will be removed in a later patch.
So move its only still used symbol to a different header specific for
the only machine still using it. Also add a few explicit includes of
<mach/hardware.h> that are implicitly available through <mach/timex.h>.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1, sent with
Message-id: 1385474690-6483-1-git-send-email-u.kleine-koenig at pengutronix.de:

 - add serveral more #include <mach/hardware.h>
 - move definition of AT91X40_MASTER_CLOCK to <mach/at91x40.h>

I didn't include Nicolas' Ack I got for v1.

BTW, the first patch should have been in reply to
1384292466-31725-1-git-send-email-u.kleine-koenig at pengutronix.de, that's why it
has 5/4 in the subject without further context.

 arch/arm/mach-at91/at91rm9200.c           | 1 +
 arch/arm/mach-at91/at91rm9200_devices.c   | 1 +
 arch/arm/mach-at91/at91rm9200_time.c      | 1 +
 arch/arm/mach-at91/at91sam9260.c          | 1 +
 arch/arm/mach-at91/at91sam9260_devices.c  | 1 +
 arch/arm/mach-at91/at91sam9261.c          | 1 +
 arch/arm/mach-at91/at91sam9261_devices.c  | 1 +
 arch/arm/mach-at91/at91sam9263.c          | 1 +
 arch/arm/mach-at91/at91sam9263_devices.c  | 1 +
 arch/arm/mach-at91/at91sam926x_time.c     | 1 +
 arch/arm/mach-at91/at91sam9g45.c          | 1 +
 arch/arm/mach-at91/at91sam9g45_devices.c  | 1 +
 arch/arm/mach-at91/at91sam9rl.c           | 1 +
 arch/arm/mach-at91/at91sam9rl_devices.c   | 1 +
 arch/arm/mach-at91/at91x40.c              | 2 +-
 arch/arm/mach-at91/at91x40_time.c         | 1 +
 arch/arm/mach-at91/board-gsia18s.c        | 1 +
 arch/arm/mach-at91/board-pcontrol-g20.c   | 1 +
 arch/arm/mach-at91/board-stamp9g20.c      | 1 +
 arch/arm/mach-at91/include/mach/at91x40.h | 2 ++
 arch/arm/mach-at91/pm.c                   | 1 +
 21 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 25805f2..a43cf95 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -21,6 +21,7 @@
 #include <mach/at91_pmc.h>
 #include <mach/at91_st.h>
 #include <mach/cpu.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "soc.h"
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 3ebc979..eb9c2798 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -21,6 +21,7 @@
 #include <mach/at91rm9200.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
+#include <mach/hardware.h>
 
 #include "board.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index f607deb..6b68b98 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -31,6 +31,7 @@
 #include <asm/mach/time.h>
 
 #include <mach/at91_st.h>
+#include <mach/hardware.h>
 
 static unsigned long last_crtr;
 static u32 irqmask;
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index d6a1fa8..5f83364 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -21,6 +21,7 @@
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9260.h>
 #include <mach/at91_pmc.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "at91_rstc.h"
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index eda8d16..a1b989e 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -25,6 +25,7 @@
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_adc.h>
+#include <mach/hardware.h>
 
 #include "board.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 23ba1d8..f17d8db 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -20,6 +20,7 @@
 #include <mach/cpu.h>
 #include <mach/at91sam9261.h>
 #include <mach/at91_pmc.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "at91_rstc.h"
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index b2a3474..b5f7a72 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -25,6 +25,7 @@
 #include <mach/at91sam9261_matrix.h>
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/hardware.h>
 
 #include "board.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 7eccb0f..fde9ea5 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -19,6 +19,7 @@
 #include <asm/system_misc.h>
 #include <mach/at91sam9263.h>
 #include <mach/at91_pmc.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "at91_rstc.h"
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 4aeaddd..39803c3 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -24,6 +24,7 @@
 #include <mach/at91sam9263_matrix.h>
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/hardware.h>
 
 #include "board.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index bb39232..b9da2b1 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -19,6 +19,7 @@
 #include <linux/of_irq.h>
 
 #include <asm/mach/time.h>
+#include <mach/hardware.h>
 
 #define AT91_PIT_MR		0x00			/* Mode Register */
 #define		AT91_PIT_PITIEN		(1 << 25)		/* Timer Interrupt Enable */
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 9405aa0..045981f 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -20,6 +20,7 @@
 #include <mach/at91sam9g45.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "soc.h"
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index cb36fa8..4e53d8d 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -32,6 +32,7 @@
 #include <mach/at91sam9_smc.h>
 #include <linux/platform_data/dma-atmel.h>
 #include <mach/atmel-mci.h>
+#include <mach/hardware.h>
 
 #include <media/atmel-isi.h>
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 0750ffb..6a7d76d 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -20,6 +20,7 @@
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9rl.h>
 #include <mach/at91_pmc.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "at91_rstc.h"
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index a698bda..f759850 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -21,6 +21,7 @@
 #include <mach/at91sam9rl_matrix.h>
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/hardware.h>
 #include <linux/platform_data/dma-atmel.h>
 
 #include "board.h"
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index bad94b8..7523f1c 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -19,7 +19,7 @@
 #include <asm/mach/arch.h>
 #include <mach/at91x40.h>
 #include <mach/at91_st.h>
-#include <mach/timex.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91x40_time.c b/arch/arm/mach-at91/at91x40_time.c
index c0e637a..07d0bf2 100644
--- a/arch/arm/mach-at91/at91x40_time.c
+++ b/arch/arm/mach-at91/at91x40_time.c
@@ -25,6 +25,7 @@
 #include <linux/time.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
+#include <mach/at91x40.h>
 #include <asm/mach/time.h>
 
 #include "at91_tc.h"
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index c1d61d2..416bae8 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -31,6 +31,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/at91sam9_smc.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "board.h"
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 65c0d6b..5f25fa5 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -30,6 +30,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/at91sam9_smc.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "board.h"
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 869cbec..e4a5ac1 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -26,6 +26,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/at91sam9_smc.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "board.h"
diff --git a/arch/arm/mach-at91/include/mach/at91x40.h b/arch/arm/mach-at91/include/mach/at91x40.h
index 9068021..38dca2b 100644
--- a/arch/arm/mach-at91/include/mach/at91x40.h
+++ b/arch/arm/mach-at91/include/mach/at91x40.h
@@ -55,4 +55,6 @@
 #define	AT91_PS_CR	(AT91_PS + 0)	/* PS Control register */
 #define	AT91_PS_CR_CPU	(1 << 0)	/* CPU clock disable bit */
 
+#define AT91X40_MASTER_CLOCK	40000000
+
 #endif /* AT91X40_H */
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 9986542..7afecb8 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -27,6 +27,7 @@
 
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
+#include <mach/hardware.h>
 
 #include "at91_aic.h"
 #include "generic.h"
-- 
1.8.4.2
