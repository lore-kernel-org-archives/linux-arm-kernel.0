From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 17 May 2011 17:42:04 -0400
Subject: [PATCH 8/9] davinci: remove definition of SRAM_VIRT
In-Reply-To: <cover.1305668470.git.bengardiner@nanometrics.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
Message-ID: <8739469073d138fef7df16207644e94953e3f7cf.1305668470.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously all platforms were iomapping their SRAM using iotable entries with
SRAM_VIRT as the target virtual address.

Remove the SRAM_VIRT definition now that all the iotables are removed and
sram init is doing ioremaps before regsitering with pv_pool_create.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 arch/arm/mach-davinci/include/mach/common.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 665d049..16b5ec5 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -86,8 +86,6 @@ extern struct davinci_soc_info davinci_soc_info;
 extern void davinci_common_init(struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
 
-/* standard place to map on-chip SRAMs; they *may* support DMA */
-#define SRAM_VIRT	0xfffe0000
 #define SRAM_SIZE	SZ_128K
 
 #endif /* __ARCH_ARM_MACH_DAVINCI_COMMON_H */
-- 
1.7.4.1
