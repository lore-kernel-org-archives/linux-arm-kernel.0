From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:18 +0100
Subject: [PATCH 23/39] arm/imx: don't depend on ARCH_MXC twice
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-23-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MXC_IRQ_PRIOR, MXC_PWM and ARCH_HAS_RNGA are all defined in an "if
ARCH_MXC" ... "endif" block, so they depend on ARCH_MXC anyhow.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/Kconfig |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 55bfe61..9c8d4e7 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -48,7 +48,6 @@ endmenu
 
 config MXC_IRQ_PRIOR
 	bool "Use IRQ priority"
-	depends on ARCH_MXC
 	help
 	  Select this if you want to use prioritized IRQ handling.
 	  This feature prevents higher priority ISR to be interrupted
@@ -59,7 +58,6 @@ config MXC_IRQ_PRIOR
 
 config MXC_PWM
 	tristate "Enable PWM driver"
-	depends on ARCH_MXC
 	select HAVE_PWM
 	help
 	  Enable support for the i.MX PWM controller(s).
@@ -69,7 +67,6 @@ config MXC_ULPI
 
 config ARCH_HAS_RNGA
 	bool
-	depends on ARCH_MXC
 
 config ARCH_MXC_IOMUX_V3
 	bool
-- 
1.6.6.2
