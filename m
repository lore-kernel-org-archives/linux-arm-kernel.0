From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 2 Nov 2011 17:25:23 +0200
Subject: [PATCH] arm/tegra: remove unused defines
Message-ID: <1320247524-22425-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PPI_NR is never used in arch/arm/mach-tegra/irq.c. Remove it.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/irq.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 4956c3c..8ad82af 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -28,10 +28,6 @@
 
 #include "board.h"
 
-#define INT_SYS_NR	(INT_GPIO_BASE - INT_PRI_BASE)
-#define INT_SYS_SZ	(INT_SEC_BASE - INT_PRI_BASE)
-#define PPI_NR		((INT_SYS_NR+INT_SYS_SZ-1)/INT_SYS_SZ)
-
 #define ICTLR_CPU_IEP_VFIQ	0x08
 #define ICTLR_CPU_IEP_FIR	0x14
 #define ICTLR_CPU_IEP_FIR_SET	0x18
-- 
1.7.7.rc0.72.g4b5ea.dirty
