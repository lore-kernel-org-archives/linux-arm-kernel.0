From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Fri, 11 Oct 2013 17:52:13 +0530
Subject: [RFC PATCH 2/4] ARM64: Include appropriate byteorder for Big Endian
In-Reply-To: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
References: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1381494135-15085-3-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use generic big_endian.h when using big endian compiler.

Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
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
