From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2012 13:36:25 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7779: use __iomem pointers for MMIO
In-Reply-To: <1350448585-26403-1-git-send-email-horms@verge.net.au>
References: <1350448585-26403-1-git-send-email-horms@verge.net.au>
Message-ID: <1350448585-26403-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

0a4b04dc299dfb691827a4001b3d8d7e443b71c9
(ARM: shmobile: use __iomem pointers for MMIO)
modified iomem pointers so that IOMEM() macro will be used,
but clock-r8a7779.c was out of target.
This patch fixes it up.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 3cafb6a..37b2a31 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -24,17 +24,17 @@
 #include <linux/clkdev.h>
 #include <mach/common.h>
 
-#define FRQMR   0xffc80014
-#define MSTPCR0 0xffc80030
-#define MSTPCR1 0xffc80034
-#define MSTPCR3 0xffc8003c
-#define MSTPSR1 0xffc80044
-#define MSTPSR4 0xffc80048
-#define MSTPSR6 0xffc8004c
-#define MSTPCR4 0xffc80050
-#define MSTPCR5 0xffc80054
-#define MSTPCR6 0xffc80058
-#define MSTPCR7 0xffc80040
+#define FRQMR		IOMEM(0xffc80014)
+#define MSTPCR0		IOMEM(0xffc80030)
+#define MSTPCR1		IOMEM(0xffc80034)
+#define MSTPCR3		IOMEM(0xffc8003c)
+#define MSTPSR1		IOMEM(0xffc80044)
+#define MSTPSR4		IOMEM(0xffc80048)
+#define MSTPSR6		IOMEM(0xffc8004c)
+#define MSTPCR4		IOMEM(0xffc80050)
+#define MSTPCR5		IOMEM(0xffc80054)
+#define MSTPCR6		IOMEM(0xffc80058)
+#define MSTPCR7		IOMEM(0xffc80040)
 
 /* ioremap() through clock mapping mandatory to avoid
  * collision with ARM coherent DMA virtual memory range.
-- 
1.7.10.4
