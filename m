From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 22:58:12 +0100
Subject: [PATCH 09/17] ARM: at91: pm: remove warning to remove SOC_AT91SAM9263
 usage
In-Reply-To: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421359100-8930-10-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SOC_AT91SAM9263 is being removed, stop using it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm_slowclock.S | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 20018779bae7..556151e85ec4 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -17,15 +17,6 @@
 #include <mach/hardware.h>
 #include <mach/at91_ramc.h>
 
-
-#ifdef CONFIG_SOC_AT91SAM9263
-/*
- * FIXME either or both the SDRAM controllers (EB0, EB1) might be in use;
- * handle those cases both here and in the Suspend-To-RAM support.
- */
-#warning Assuming EB1 SDRAM controller is *NOT* used
-#endif
-
 /*
  * When SLOWDOWN_MASTER_CLOCK is defined we will also slow down the Master
  * clock during suspend by adjusting its prescalar and divisor.
-- 
2.1.0
