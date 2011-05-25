From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 25 May 2011 11:34:57 +0200
Subject: [PATCH] arm: mxs: include asm/processor.h for cpu_relax()
Message-ID: <1306316097-27926-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I get this build error as of today:

arch/arm/mach-mxs/ocotp.c: In function 'mxs_get_ocotp':
arch/arm/mach-mxs/ocotp.c:54: error: implicit declaration of function 'cpu_relax'
make[2]: *** [arch/arm/mach-mxs/ocotp.o] Error 1

Looks like it has been indirectly included before which broke now.
Include it directly.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/ocotp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
index 65157a3..54add60 100644
--- a/arch/arm/mach-mxs/ocotp.c
+++ b/arch/arm/mach-mxs/ocotp.c
@@ -16,6 +16,8 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 
+#include <asm/processor.h>	/* for cpu_relax() */
+
 #include <mach/mxs.h>
 
 #define OCOTP_WORD_OFFSET		0x20
-- 
1.7.2.5
