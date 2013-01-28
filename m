From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 28 Jan 2013 13:30:50 +0100
Subject: [PATCH] arm: zynq: Add missing irqchip.h to common.c
Message-ID: <1359376250-18841-1-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch: "ARM: use common irqchip_init for GIC init"
(sha1: 0529e315bbda5d502c93df2cfafba9bb337fbdf4)
should also add linux/irqchip.h header.

Error message:
arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init'
  undeclared here (not in a function)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 6472a69..cf3ec54 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -24,6 +24,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/of.h>
+#include <linux/irqchip.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-- 
1.7.0.4
