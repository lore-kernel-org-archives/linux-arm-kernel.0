From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Dec 2012 10:18:40 -0800
Subject: [PATCH v2 5/7] arm: zynq: timer: Remove redundant #includes
In-Reply-To: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
References: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
Message-ID: <21207fff-dd51-4099-88f8-eea754e3d19c@CO1EHSMHS021.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some #includes are implicitly included through others, some are
just not needed.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/mach-zynq/timer.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index 4b81ae1..2b23d0f 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -15,20 +15,12 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/types.h>
-#include <linux/clocksource.h>
 #include <linux/clockchips.h>
-#include <linux/io.h>
-#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
-
 #include "common.h"
 
 /*
-- 
1.8.0.2
