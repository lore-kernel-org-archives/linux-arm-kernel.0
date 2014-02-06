From: pratyush.anand@st.com (Pratyush Anand)
Date: Thu, 6 Feb 2014 10:14:49 +0530
Subject: [PATCH V4 2/8] SPEAr13xx: Fix static mapping table
In-Reply-To: <cover.1391661589.git.pratyush.anand@st.com>
References: <cover.1391661589.git.pratyush.anand@st.com>
Message-ID: <4258166515f894425cd2a9a19b8872012f377276.1391661589.git.pratyush.anand@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPEAr13xx was using virtual address space 0xFE000000 to map physical address
space 0xB3000000. pci_remap_io uses 0xFEE00000 as virtual address. So
change 0xFE000000 to 0xF9000000.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel at list.st.com
Cc: stable at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-spear/include/mach/spear.h | 4 ++--
 arch/arm/mach-spear/spear13xx.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index 5cdc53d..f2d6a01 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -52,10 +52,10 @@
 #ifdef CONFIG_ARCH_SPEAR13XX
 
 #define PERIP_GRP2_BASE				UL(0xB3000000)
-#define VA_PERIP_GRP2_BASE			IOMEM(0xFE000000)
+#define VA_PERIP_GRP2_BASE			IOMEM(0xF9000000)
 #define MCIF_SDHCI_BASE				UL(0xB3000000)
 #define SYSRAM0_BASE				UL(0xB3800000)
-#define VA_SYSRAM0_BASE				IOMEM(0xFE800000)
+#define VA_SYSRAM0_BASE				IOMEM(0xF9800000)
 #define SYS_LOCATION				(VA_SYSRAM0_BASE + 0x600)
 
 #define PERIP_GRP1_BASE				UL(0xE0000000)
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 7aa6e8c..89212ff 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -52,7 +52,7 @@ void __init spear13xx_l2x0_init(void)
 /*
  * Following will create 16MB static virtual/physical mappings
  * PHYSICAL		VIRTUAL
- * 0xB3000000		0xFE000000
+ * 0xB3000000		0xF9000000
  * 0xE0000000		0xFD000000
  * 0xEC000000		0xFC000000
  * 0xED000000		0xFB000000
-- 
1.8.1.2
