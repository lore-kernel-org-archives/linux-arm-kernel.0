From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Fri,  9 Nov 2018 23:47:47 +0300
Subject: [PATCH] arm64: sysreg: fix sparse warnings
Message-ID: <20181109204747.10008-1-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify correct type for the constants to avoid
the following sparse complaints:

./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/arm64/include/asm/sysreg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 0c909c4a932f..e025aaa35178 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -468,7 +468,7 @@
 			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
 			 SCTLR_ELx_DSSBS | ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
 
-#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffff
+#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffffULL
 #error "Inconsistent SCTLR_EL2 set/clear bits"
 #endif
 
@@ -509,7 +509,7 @@
 			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
 			 SCTLR_ELx_DSSBS | SCTLR_EL1_NTWI  | SCTLR_EL1_RES0)
 
-#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffffffffffff
+#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffffffffffffULL
 #error "Inconsistent SCTLR_EL1 set/clear bits"
 #endif
 
-- 
2.11.0
