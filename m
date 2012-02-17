From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Feb 2012 21:32:13 -0600
Subject: [PATCH 3/4] ARM: pxa: mainstone: add missing include for
 IRQ_BOARD_START
In-Reply-To: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329449534-23811-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

As part of mach/irqs.h include removal from sparse, mainstone.h was missed.
This fixes the compile of the pcmcia driver.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-pxa/include/mach/mainstone.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mainstone.h b/arch/arm/mach-pxa/include/mach/mainstone.h
index 4c2d11c..1bfc4e8 100644
--- a/arch/arm/mach-pxa/include/mach/mainstone.h
+++ b/arch/arm/mach-pxa/include/mach/mainstone.h
@@ -13,6 +13,8 @@
 #ifndef ASM_ARCH_MAINSTONE_H
 #define ASM_ARCH_MAINSTONE_H
 
+#include <mach/irqs.h>
+
 #define MST_ETH_PHYS		PXA_CS4_PHYS
 
 #define MST_FPGA_PHYS		PXA_CS2_PHYS
-- 
1.7.5.4
