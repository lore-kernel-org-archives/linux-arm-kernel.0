From: x0095840@ti.com (Fernando Guzman Lugo)
Date: Fri,  1 Oct 2010 11:28:41 -0500
Subject: [PATCH] scatterlist: define SG chain for arm architecture
Message-ID: <1285950521-8093-1-git-send-email-x0095840@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define SG chain for ARM architecture in order to work
with big buffers. This patch is needed in order to
iovmm users can pass a big buffer to map it and ARM
architecture has not issues using SG chain.

This change was suggested by FUJITA Tomonori.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/include/asm/scatterlist.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/scatterlist.h b/arch/arm/include/asm/scatterlist.h
index 2f87870..3de0a0b 100644
--- a/arch/arm/include/asm/scatterlist.h
+++ b/arch/arm/include/asm/scatterlist.h
@@ -5,4 +5,6 @@
 #include <asm/types.h>
 #include <asm-generic/scatterlist.h>
 
+#define ARCH_HAS_SG_CHAIN
+
 #endif /* _ASMARM_SCATTERLIST_H */
-- 
1.6.3.3
