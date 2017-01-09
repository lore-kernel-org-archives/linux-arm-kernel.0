From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:23:57 -0500
Subject: [RFC 01/55] arm64: Add missing TCR hw defines
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-2-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Some bits of the TCR weren't defined and since we're about to use these
in KVM, add these defines.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eb0c2bd..d26cab7 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -272,9 +272,15 @@
 #define TCR_TG1_4K		(UL(2) << TCR_TG1_SHIFT)
 #define TCR_TG1_64K		(UL(3) << TCR_TG1_SHIFT)
 
+#define TCR_IPS_SHIFT		32
+#define TCR_IPS_MASK		(UL(7) << TCR_IPS_SHIFT)
+
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
 
+#define TCR_EPD1		(UL(1) << 23)
+#define TCR_EPD0		(UL(1) << 7)
+
 #endif
-- 
1.9.1
