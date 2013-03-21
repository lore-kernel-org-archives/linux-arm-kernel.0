From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 21 Mar 2013 17:26:14 +0100
Subject: [PATCH 1/5] arm: mvebu: Aligne the internal registers virtual base to
 support LPAE
In-Reply-To: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1363883179-1361-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lior Amsalem <alior@marvell.com>

In order to be able to support he LPAE, the internal registers virtual
base must be aligned to 2MB.

Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/include/debug/mvebu.S      |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/debug/mvebu.S b/arch/arm/include/debug/mvebu.S
index 865c6d0..df191af 100644
--- a/arch/arm/include/debug/mvebu.S
+++ b/arch/arm/include/debug/mvebu.S
@@ -12,7 +12,7 @@
 */
 
 #define ARMADA_370_XP_REGS_PHYS_BASE	0xd0000000
-#define ARMADA_370_XP_REGS_VIRT_BASE	0xfeb00000
+#define ARMADA_370_XP_REGS_VIRT_BASE	0xfec00000
 
 	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =ARMADA_370_XP_REGS_PHYS_BASE
diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index c6a7d74..c49c08e 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -16,7 +16,7 @@
 #define __MACH_ARMADA_370_XP_H
 
 #define ARMADA_370_XP_REGS_PHYS_BASE	0xd0000000
-#define ARMADA_370_XP_REGS_VIRT_BASE	IOMEM(0xfeb00000)
+#define ARMADA_370_XP_REGS_VIRT_BASE	IOMEM(0xfec00000)
 #define ARMADA_370_XP_REGS_SIZE		SZ_1M
 
 #ifdef CONFIG_SMP
-- 
1.7.9.5
