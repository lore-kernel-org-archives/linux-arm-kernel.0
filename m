From: jc.lee@samsung.com (Jaecheol Lee)
Date: Wed, 15 Sep 2010 16:52:38 +0900
Subject: [PATCH 1/5] ARM: S5PV210: Add support DMC map_desc table
In-Reply-To: <1284537162-3129-1-git-send-email-jc.lee@samsung.com>
References: <1284537162-3129-1-git-send-email-jc.lee@samsung.com>
Message-ID: <1284537162-3129-2-git-send-email-jc.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMC(DRAM Memory Controller) map_desc table.
Because some driver such as CPUFREQ need to access DMC register.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
---
 arch/arm/mach-s5pv210/cpu.c              |   10 ++++++++++
 arch/arm/mach-s5pv210/include/mach/map.h |    3 +++
 arch/arm/plat-s5p/include/plat/map-s5p.h |    2 ++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index c551ab1..aebbb7f 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -84,6 +84,16 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S5PV210_PA_SROMC),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_DMC0,
+		.pfn		= __phys_to_pfn(S5PV210_PA_DMC0),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_DMC1,
+		.pfn		= __phys_to_pfn(S5PV210_PA_DMC1),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
 	}
 };
 
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index bd9afd5..3e89c22 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -96,6 +96,9 @@
 
 #define S5PV210_PA_ADC		(0xE1700000)
 
+#define S5PV210_PA_DMC0		(0xF0000000)
+#define S5PV210_PA_DMC1		(0xF1400000)
+
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
 #define S3C_PA_HSMMC0		S5PV210_PA_HSMMC(0)
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index c4ff88b..2472894 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -18,6 +18,8 @@
 #define S5P_VA_SYSTIMER		S3C_ADDR(0x01200000)
 #define S5P_VA_SROMC		S3C_ADDR(0x01100000)
 #define S5P_VA_SYSRAM		S3C_ADDR(0x01180000)
+#define S5P_VA_DMC0		S3C_ADDR(0x00A00000)
+#define S5P_VA_DMC1		S3C_ADDR(0x00A80000)
 
 #define S5P_VA_COMBINER_BASE	S3C_ADDR(0x00600000)
 #define S5P_VA_COMBINER(x)	(S5P_VA_COMBINER_BASE + ((x) >> 2) * 0x10)
-- 
1.6.2.5
