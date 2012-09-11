From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:22 +0200
Subject: [PATCH v4 09/17] arm: mach-mvebu: use IOMEM() for base address
 definitions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now define all virtual base address constants using IOMEM() so that
those are naturally typed as void __iomem pointers, and we do the
necessary adjustements in the mach-mvebu code.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c              |    2 +-
 arch/arm/mach-mvebu/include/mach/armada-370-xp.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 4ef923b..dfe635b 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -25,7 +25,7 @@
 
 static struct map_desc armada_370_xp_io_desc[] __initdata = {
 	{
-		.virtual	= ARMADA_370_XP_REGS_VIRT_BASE,
+		.virtual	= (unsigned long) ARMADA_370_XP_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(ARMADA_370_XP_REGS_PHYS_BASE),
 		.length		= ARMADA_370_XP_REGS_SIZE,
 		.type		= MT_DEVICE,
diff --git a/arch/arm/mach-mvebu/include/mach/armada-370-xp.h b/arch/arm/mach-mvebu/include/mach/armada-370-xp.h
index 25f0ca8..aac9beb 100644
--- a/arch/arm/mach-mvebu/include/mach/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/include/mach/armada-370-xp.h
@@ -16,7 +16,7 @@
 #define __MACH_ARMADA_370_XP_H
 
 #define ARMADA_370_XP_REGS_PHYS_BASE	0xd0000000
-#define ARMADA_370_XP_REGS_VIRT_BASE	0xfeb00000
+#define ARMADA_370_XP_REGS_VIRT_BASE	IOMEM(0xfeb00000)
 #define ARMADA_370_XP_REGS_SIZE		SZ_1M
 
 #endif /* __MACH_ARMADA_370_XP_H */
-- 
1.7.9.5
