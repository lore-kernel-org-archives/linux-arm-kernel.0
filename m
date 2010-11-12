From: davidb@codeaurora.org (David Brown)
Date: Fri, 12 Nov 2010 13:49:53 -0800
Subject: [PATCH 3/3] msm: Warning cleanup
In-Reply-To: <1289598593-8974-1-git-send-email-davidb@codeaurora.org>
References: <1289598593-8974-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1289598593-8974-3-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define VMALLOC_END as an unsigned long to match expected type.
Eliminates a warning:

arch/arm/mm/init.c: In function 'mem_init':
arch/arm/mm/init.c:606: warning: format '%08lx' expects type
   'long unsigned int', but argument 12 has type 'unsigned int'

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/vmalloc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/vmalloc.h b/arch/arm/mach-msm/include/mach/vmalloc.h
index 31a32ad..d138448 100644
--- a/arch/arm/mach-msm/include/mach/vmalloc.h
+++ b/arch/arm/mach-msm/include/mach/vmalloc.h
@@ -16,7 +16,7 @@
 #ifndef __ASM_ARCH_MSM_VMALLOC_H
 #define __ASM_ARCH_MSM_VMALLOC_H
 
-#define VMALLOC_END	  0xd0000000
+#define VMALLOC_END	  0xd0000000UL
 
 #endif
 
-- 
1.7.3.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
