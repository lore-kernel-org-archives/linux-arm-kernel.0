From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 10 Aug 2010 14:44:07 +0900
Subject: [PATCH v7 4/6] ARM: S5PV210: Access for DMCx registers
In-Reply-To: <1281419049-11562-4-git-send-email-myungjoo.ham@samsung.com>
References: <1281419049-11562-1-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-2-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-3-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-4-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1281419049-11562-5-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	The CPUFREQ driver requires an access to DMCx registers. We
define addresses of DMCx registers and mapping between physical and
virtual addresses of DMCx registers.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
v7
	- removed unnecessary comment.
	- merged the two patches (virtual address + physical address)

---
 arch/arm/mach-s5pv210/cpu.c              |   12 +++++++++++-
 arch/arm/mach-s5pv210/include/mach/map.h |    3 +++
 arch/arm/plat-s5p/include/plat/map-s5p.h |    3 +++
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 5d1e46e..7f58435 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -60,7 +60,17 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S5PV210_PA_SROMC),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
-	}
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
+	},
 };
 
 static void s5pv210_idle(void)
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 17687f0..019c5b8 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -108,4 +108,7 @@
 #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
 #define SAMSUNG_PA_KEYPAD	S5PV210_PA_KEYPAD
 
+#define S5PV210_PA_DMC0		(0xF0000000)
+#define S5PV210_PA_DMC1		(0xF1400000)
+
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 1482852..bd803f1 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -31,4 +31,7 @@
 #define VA_VIC2			VA_VIC(2)
 #define VA_VIC3			VA_VIC(3)
 
+#define S5P_VA_DMC0		S3C_ADDR(0x00a00000)
+#define S5P_VA_DMC1		S3C_ADDR(0x00b00000)
+
 #endif /* __ASM_PLAT_MAP_S5P_H */
-- 
1.6.3.3
