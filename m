From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:52 -0700
Subject: [PATCH 23/25] msm: physical offset for MSM7X30
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-24-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM7x30 does not have a separate bank of memory for shared
memory communication with the radio CPU.  Set the kernel base
address 2MB in, to use this first 2MB for this purpose.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/memory.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
index cfee996..50c7847 100644
--- a/arch/arm/mach-msm/include/mach/memory.h
+++ b/arch/arm/mach-msm/include/mach/memory.h
@@ -21,6 +21,8 @@
 #define PHYS_OFFSET		UL(0x00000000)
 #elif defined(CONFIG_ARCH_QSD8X50)
 #define PHYS_OFFSET		UL(0x20000000)
+#elif defined(CONFIG_ARCH_MSM7X30)
+#define PHYS_OFFSET		UL(0x00200000)
 #else
 #define PHYS_OFFSET		UL(0x10000000)
 #endif
-- 
1.6.2.3
