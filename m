From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 13 Jul 2015 14:25:49 +0100
Subject: [PATCH v2 02/10] arm64/debug: Mask off all reserved bits from
 generated ESR values
In-Reply-To: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1436793967-7138-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are only 16 comment bits in a BRK instruction, which
correspond to ESR bits 15:0.  Bits 24:16 of the ESR are RES0,
and might have weird meanings in the future.

This code inserts 16 bits of comment in the ESR value instead of
20 (almost certainly a typo in the original code).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index f3d2dbd..ab7d5a8 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -45,7 +45,7 @@
 /*
  * ESR values expected for dynamic and compile time BRK instruction
  */
-#define DBG_ESR_VAL_BRK(x)	(0xf2000000 | ((x) & 0xfffff))
+#define DBG_ESR_VAL_BRK(x)	(0xf2000000 | ((x) & 0xffff))
 
 /*
  * #imm16 values used for BRK instruction generation
-- 
1.7.10.4
