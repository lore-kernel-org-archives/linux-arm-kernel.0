From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Aug 2010 21:33:46 +0900
Subject: [PATCH 1/3] ARM: SAMSUNG: Change the 3rd HSMMC interrupt name for
	compatibility
In-Reply-To: <1282307628-5254-1-git-send-email-kgene.kim@samsung.com>
References: <1282307628-5254-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282307628-5254-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the 3rd HSMMC interrupt name for compatibility
from IRQ_MMC to IRQ_HSMMC3.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/irqs.h |    2 +-
 arch/arm/mach-s5pv310/include/mach/irqs.h |    5 +++++
 arch/arm/plat-samsung/dev-hsmmc3.c        |    4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index e1c020e..cdb8ae4 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -109,7 +109,7 @@
 
 #define IRQ_IPC			S5P_IRQ_VIC3(0)
 #define IRQ_HOSTIF		S5P_IRQ_VIC3(1)
-#define IRQ_MMC3		S5P_IRQ_VIC3(2)
+#define IRQ_HSMMC3		S5P_IRQ_VIC3(2)
 #define IRQ_CEC			S5P_IRQ_VIC3(3)
 #define IRQ_TSI			S5P_IRQ_VIC3(4)
 #define IRQ_MDNIE0		S5P_IRQ_VIC3(5)
diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index 4cdedda..522352f 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -68,6 +68,11 @@
 
 #define IRQ_IIC			COMBINER_IRQ(27, 0)
 
+#define IRQ_HSMMC0		COMBINER_IRQ(29, 0)
+#define IRQ_HSMMC1		COMBINER_IRQ(29, 1)
+#define IRQ_HSMMC2		COMBINER_IRQ(29, 2)
+#define IRQ_HSMMC3		COMBINER_IRQ(29, 3)
+
 /* Set the default NR_IRQS */
 
 #define NR_IRQS			COMBINER_IRQ(MAX_COMBINER_NR, 0)
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
index 85aaf0f..335bc35 100644
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ b/arch/arm/plat-samsung/dev-hsmmc3.c
@@ -33,8 +33,8 @@ static struct resource s3c_hsmmc3_resource[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_MMC3,
-		.end	= IRQ_MMC3,
+		.start	= IRQ_HSMMC3,
+		.end	= IRQ_HSMMC3,
 		.flags	= IORESOURCE_IRQ,
 	}
 };
-- 
1.6.2.5
