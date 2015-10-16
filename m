From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Oct 2015 16:10:05 -0500
Subject: [PATCH] clocksource: ti-32k: make it depend on GENERIC_CLOCKSOURCE
In-Reply-To: <201510170412.4siQMwFD%fengguang.wu@intel.com>
References: <201510170412.4siQMwFD%fengguang.wu@intel.com>
Message-ID: <1445029805-13736-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the new ti 32k clocksource driver should depend on
GENERIC_CLOCKSOURCE because of its reliance on
sched_clock_register().

Let's enable that to avoid any possible build errors
and/or warnings on randbuilds.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 98b2a9b9bfad..3a1efa3fd88d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -117,6 +117,7 @@ config CLKSRC_PISTACHIO
 
 config CLKSRC_TI_32K
 	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
+	depends on GENERIC_SCHED_CLOCK
 	select CLKSRC_OF if OF
 	help
 	  This option enables support for Texas Instruments 32.768 Hz clocksource
-- 
2.5.3
