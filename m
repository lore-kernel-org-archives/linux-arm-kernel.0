From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Nov 2010 10:46:07 +0100
Subject: [PATCH 3/7] ARM i.MX51: Make CONFIG_MXC_TZIC an invisible option
In-Reply-To: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
References: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288950371-1552-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no point showing this option to the user. The correct
value will be selected anyway.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/Kconfig |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 31d07c0..8c6cd50 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -69,12 +69,7 @@ config MXC_IRQ_PRIOR
 	  Say N here, unless you have a specialized requirement.
 
 config MXC_TZIC
-	bool "Enable TrustZone Interrupt Controller"
-	depends on ARCH_MX51
-	help
-	  This will be automatically selected for all processors
-	  containing this interrupt controller.
-	  Say N here only if you are really sure.
+	bool
 
 config MXC_AVIC
 	bool
-- 
1.7.2.3
