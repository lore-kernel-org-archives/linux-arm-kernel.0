From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Fri, 16 Nov 2018 21:21:30 +0300
Subject: [PATCH v2] arm64: sysreg: fix sparse warnings
Message-ID: <20181116182130.4327-1-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify correct type for the constants to avoid
the following sparse complaints:

./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---

Changes v1 -> v2
  - use proper type: UL rather than ULL

 arch/arm64/include/asm/sysreg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 0c909c4a932f..842fb9572661 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -468,7 +468,7 @@
 			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
 			 SCTLR_ELx_DSSBS | ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
 
-#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffff
+#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffffUL
 #error "Inconsistent SCTLR_EL2 set/clear bits"
 #endif
 
@@ -509,7 +509,7 @@
 			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
 			 SCTLR_ELx_DSSBS | SCTLR_EL1_NTWI  | SCTLR_EL1_RES0)
 
-#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffffffffffff
+#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffffffffffffUL
 #error "Inconsistent SCTLR_EL1 set/clear bits"
 #endif
 
-- 
2.11.0
