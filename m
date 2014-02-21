From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:01 +0900
Subject: [PATCH] sh: intc: Enable driver compilation with COMPILE_TEST
In-Reply-To: <cover.1392962498.git.horms+renesas@verge.net.au>
References: <cover.1392962498.git.horms+renesas@verge.net.au>
Message-ID: <4f3068f60503e08bc9e729528d9e54289980fa96.1392962498.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

This helps increasing build testing coverage.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/intc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/intc/Kconfig b/drivers/sh/intc/Kconfig
index a305731..f7d9061 100644
--- a/drivers/sh/intc/Kconfig
+++ b/drivers/sh/intc/Kconfig
@@ -6,7 +6,7 @@ comment "Interrupt controller options"
 
 config INTC_USERIMASK
 	bool "Userspace interrupt masking support"
-	depends on ARCH_SHMOBILE || (SUPERH && CPU_SH4A)
+	depends on ARCH_SHMOBILE || (SUPERH && CPU_SH4A) || COMPILE_TEST
 	help
 	  This enables support for hardware-assisted userspace hardirq
 	  masking.
-- 
1.8.5.2
