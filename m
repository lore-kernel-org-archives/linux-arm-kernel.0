From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 Nov 2018 17:54:56 -0800
Subject: [PATCH] arm64: Explicitly mark 64-bit constant as unsigned long
Message-ID: <20181117015456.101222-1-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makes sparse happy. Before:

arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/include/asm/sysreg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 0c909c4a932ff..981892b67b8f6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -468,7 +468,7 @@
 			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
 			 SCTLR_ELx_DSSBS | ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
 
-#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffff
+#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xfffffffffffffffful
 #error "Inconsistent SCTLR_EL2 set/clear bits"
 #endif
 
@@ -509,7 +509,7 @@
 			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
 			 SCTLR_ELx_DSSBS | SCTLR_EL1_NTWI  | SCTLR_EL1_RES0)
 
-#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffffffffffff
+#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xfffffffffffffffful
 #error "Inconsistent SCTLR_EL1 set/clear bits"
 #endif
 
-- 
2.11.0
