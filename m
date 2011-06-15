From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 Jun 2011 16:02:39 +0300
Subject: [RESEND PATCH 1/2] arm: Kconfig: select correct HAVE_SPARSE_IRQ symbol
In-Reply-To: <1308142960-20767-1-git-send-email-balbi@ti.com>
References: <1308142960-20767-1-git-send-email-balbi@ti.com>
Message-ID: <1308142960-20767-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit e2a93ecc7fc469dab52323c11a2d8ceaa62aac7b
(ARM: Use genirq definitions from kernel/irq/Kconfig)
made ARM Kconfig use the generic Kconfig symbols from
kernel/irq/Kconfig but did not fix the boards which
were using the older symbols, fix them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..a061525 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -545,7 +545,7 @@ config ARCH_MMP
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
@@ -617,7 +617,7 @@ config ARCH_PXA
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-- 
1.7.6.rc1
