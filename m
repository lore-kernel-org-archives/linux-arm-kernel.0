From: mohit.kumar@st.com (Mohit Kumar)
Date: Thu, 23 Jan 2014 16:02:46 +0530
Subject: [PATCH V2 6/8] SPEAr13xx: Fix static mapping table
In-Reply-To: <cover.1390471111.git.mohit.kumar@st.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
Message-ID: <22d2e7d6fbd5a291cdecf6a4d1e294d9c9ede617.1390471111.git.mohit.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <pratyush.anand@st.com>

SPEAr13xx was using virtual address space 0xFE000000 to map physical address
space 0xB3000000. pci_remap_io uses 0xFEE00000 as virtual address. So
change 0xFE000000 to 0xF9000000.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Tested-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel at list.st.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear/include/mach/spear.h |    4 ++--
 arch/arm/mach-spear/spear13xx.c          |    2 +-
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
index 7aa6e8c..20ce885 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -52,10 +52,10 @@ void __init spear13xx_l2x0_init(void)
 /*
  * Following will create 16MB static virtual/physical mappings
  * PHYSICAL		VIRTUAL
- * 0xB3000000		0xFE000000
  * 0xE0000000		0xFD000000
  * 0xEC000000		0xFC000000
  * 0xED000000		0xFB000000
+ * 0xB3000000		0xF9000000
  */
 struct map_desc spear13xx_io_desc[] __initdata = {
 	{
-- 
1.7.0.1
