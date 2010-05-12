From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:43 -0700
Subject: [PATCH 14/25] msm: physical offset for QSD8x50
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-15-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support different RAM base addresses used by Qualcomm SOCs, with
QSD8x50 as the first addtional one.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/memory.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
index f4698ba..cfee996 100644
--- a/arch/arm/mach-msm/include/mach/memory.h
+++ b/arch/arm/mach-msm/include/mach/memory.h
@@ -17,7 +17,13 @@
 #define __ASM_ARCH_MEMORY_H
 
 /* physical offset of RAM */
+#if defined(CONFIG_ARCH_QSD8X50) && defined(CONFIG_MSM_SOC_REV_A)
+#define PHYS_OFFSET		UL(0x00000000)
+#elif defined(CONFIG_ARCH_QSD8X50)
+#define PHYS_OFFSET		UL(0x20000000)
+#else
 #define PHYS_OFFSET		UL(0x10000000)
+#endif
 
 #endif
 
-- 
1.6.2.3
