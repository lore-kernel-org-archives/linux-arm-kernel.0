From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 21 Jul 2014 15:45:53 +0800
Subject: [PATCH 1/3] ARM: smp_scu: use macro for SCU enable bit
In-Reply-To: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
References: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1405928755-19413-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use macro instead of magic number for SCU enable bit.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/kernel/smp_scu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 1aafa0d785eb..c947508f84e6 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -17,6 +17,7 @@
 #include <asm/cputype.h>
 
 #define SCU_CTRL		0x00
+#define SCU_ENABLE		(1 << 0)
 #define SCU_CONFIG		0x04
 #define SCU_CPU_STATUS		0x08
 #define SCU_INVALIDATE		0x0c
@@ -50,10 +51,10 @@ void scu_enable(void __iomem *scu_base)
 
 	scu_ctrl = readl_relaxed(scu_base + SCU_CTRL);
 	/* already enabled? */
-	if (scu_ctrl & 1)
+	if (scu_ctrl & SCU_ENABLE)
 		return;
 
-	scu_ctrl |= 1;
+	scu_ctrl |= SCU_ENABLE;
 	writel_relaxed(scu_ctrl, scu_base + SCU_CTRL);
 
 	/*
-- 
1.9.1
