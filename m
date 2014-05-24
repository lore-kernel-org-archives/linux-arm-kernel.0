From: apinski@cavium.com (Andrew Pinski)
Date: Sat, 24 May 2014 00:02:00 -0700
Subject: [PATCH 05/24] ARM64:UAPI: Set the correct __BITS_PER_LONG for ILP32.
In-Reply-To: <1400914939-9708-1-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
Message-ID: <1400914939-9708-6-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to say to the userland API that bits per long is 32bits for ILP32.

Thanks,
Andrew Pinski

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/uapi/asm/bitsperlong.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/bitsperlong.h b/arch/arm64/include/uapi/asm/bitsperlong.h
index fce9c29..5e06c59 100644
--- a/arch/arm64/include/uapi/asm/bitsperlong.h
+++ b/arch/arm64/include/uapi/asm/bitsperlong.h
@@ -16,7 +16,12 @@
 #ifndef __ASM_BITSPERLONG_H
 #define __ASM_BITSPERLONG_H
 
-#define __BITS_PER_LONG 64
+/* Assuming __LP64__ will be defined for native ELF64's and not for ILP32. */
+#ifdef __LP64__
+# define __BITS_PER_LONG 64
+#else
+# define __BITS_PER_LONG 32
+#endif
 
 #include <asm-generic/bitsperlong.h>
 
-- 
1.7.2.5
