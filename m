From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 17:22:03 +0900
Subject: [PATCH 05/11] ARM: shmobile: bockw: add CN9 SCIF/RCAN selection
 dipswitch explanation
In-Reply-To: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
References: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370593329-27559-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Debug serial (= SCIF0) is connected to CN9 upper side,
and it is shared by RCAN.
This patch adds SCIF/RCAN dipswitch explanation on
comment area for developers.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index badde08..3ce020a 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -26,6 +26,14 @@
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
 
+/*
+ *	CN9(Upper side) SCIF/RCAN selection
+ *
+ *		1,4	3,6
+ * SW40		SCIF	RCAN
+ * SW41		SCIF	RCAN
+ */
+
 static struct smsc911x_platform_config smsc911x_data = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
-- 
1.8.2.1
