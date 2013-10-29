From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 23:37:50 +0100
Subject: [PATCH v2 15/19] sh: intc: Enable the driver on all ARM platforms
In-Reply-To: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383086274-11049-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
COMPILE_TEST.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/sh/intc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/intc/Kconfig b/drivers/sh/intc/Kconfig
index a305731..51e106f 100644
--- a/drivers/sh/intc/Kconfig
+++ b/drivers/sh/intc/Kconfig
@@ -6,7 +6,7 @@ comment "Interrupt controller options"
 
 config INTC_USERIMASK
 	bool "Userspace interrupt masking support"
-	depends on ARCH_SHMOBILE || (SUPERH && CPU_SH4A)
+	depends on ARM || (SUPERH && CPU_SH4A) || COMPILE_TEST
 	help
 	  This enables support for hardware-assisted userspace hardirq
 	  masking.
-- 
1.8.1.5
