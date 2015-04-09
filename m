From: stefan@agner.ch (Stefan Agner)
Date: Thu,  9 Apr 2015 22:04:08 +0200
Subject: [PATCH v5 04/11] ARM: ARMv7M: define size of vector table for Vybrid
In-Reply-To: <1428609855-27657-1-git-send-email-stefan@agner.ch>
References: <1428609855-27657-1-git-send-email-stefan@agner.ch>
Message-ID: <1428609855-27657-5-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vybrids has 112 peripherial interrupts which can be routed to the
Cortex-M4's NVIC interrupt controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 16d077e..8eebc0d 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -609,6 +609,7 @@ config CPUV7M_NUM_IRQ
 	depends on CPU_V7M
 	default 90 if ARCH_STM32
 	default 38 if ARCH_EFM32
+	default 112 if SOC_VF610
 	default 240
 	help
 	  This option indicates the number of interrupts connected to the NVIC.
-- 
2.3.5
