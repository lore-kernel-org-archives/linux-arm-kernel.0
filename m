From: balbi@ti.com (Felipe Balbi)
Date: Tue,  4 Jan 2011 14:02:56 +0200
Subject: [PATCH 3/4] arm: Kconfig: remove duplicated SPARSE_IRQ entry
In-Reply-To: <1294142577-28772-1-git-send-email-balbi@ti.com>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
Message-ID: <1294142577-28772-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPARSE_IRQ is defined under kernel/irq/Kconfig so
it's safe to remove the duplicated entry.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e6f0f8b..106d9f6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -504,7 +504,7 @@ config ARCH_MMP
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
@@ -583,7 +583,7 @@ config ARCH_PXA
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
@@ -1392,15 +1392,6 @@ config HW_PERF_EVENTS
 	  Enable hardware performance counter support for perf events. If
 	  disabled, perf events will use software events only.
 
-config SPARSE_IRQ
-	def_bool n
-	help
-	  This enables support for sparse irqs. This is useful in general
-	  as most CPUs have a fairly sparse array of IRQ vectors, which
-	  the irq_desc then maps directly on to. Systems with a high
-	  number of off-chip IRQs will want to treat this as
-	  experimental until they have been independently verified.
-
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-- 
1.7.3.4.598.g85356
