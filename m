From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Jul 2011 18:20:17 +0800
Subject: [PATCH] ARM: mmp: remove SPARSE_IRQ for mmp
Message-ID: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to use SPARSE_IRQ for mmp. There will be irq domain translation between
DT irq specifier and the Linux irq number.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 17507b8..48748fb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -545,7 +545,6 @@ config ARCH_MMP
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
-- 
1.5.6.5
