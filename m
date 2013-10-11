From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:09 +0100
Subject: [PATCH 03/14] arm64: big-endian: fix byteorder include
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-4-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

For big-endian processors, we must include
linux/byteorder/big_endian.h to get the relevant definitions for
swabbing between CPU order and a defined endianness.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/uapi/asm/byteorder.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/byteorder.h b/arch/arm64/include/uapi/asm/byteorder.h
index 2b92046..dc19e95 100644
--- a/arch/arm64/include/uapi/asm/byteorder.h
+++ b/arch/arm64/include/uapi/asm/byteorder.h
@@ -16,6 +16,10 @@
 #ifndef __ASM_BYTEORDER_H
 #define __ASM_BYTEORDER_H
 
+#ifdef __AARCH64EB__
+#include <linux/byteorder/big_endian.h>
+#else
 #include <linux/byteorder/little_endian.h>
+#endif
 
 #endif	/* __ASM_BYTEORDER_H */
-- 
1.7.9.5
