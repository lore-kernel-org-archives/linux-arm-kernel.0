From: tchalamarla@caviumnetworks.com (tchalamarla at caviumnetworks.com)
Date: Fri, 5 Feb 2016 11:28:16 -0800
Subject: [PATCH] arm64: KVM: Add 48bit PA support for EL2  translations
Message-ID: <1454700496-21221-1-git-send-email-tchalamarla@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>

Systems where RAM is at higher address and MultiNode systems
whith higher address RAM, 39 bit max PA for EL2 translations
is not sufficient.

This patch sets max possible PA(48bit) for EL2 translations.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
---
 arch/arm64/include/asm/kvm_arm.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 738a95f..3fc38a4 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -98,7 +98,12 @@
 #define TCR_EL2_RES1	((1 << 31) | (1 << 23))
 #define TCR_EL2_TBI	(1 << 20)
 #define TCR_EL2_PS	(7 << 16)
+#define TCR_EL2_PS_32B	(0 << 16)
+#define TCR_EL2_PS_36B	(1 << 16)
 #define TCR_EL2_PS_40B	(2 << 16)
+#define TCR_EL2_PS_42B	(3 << 16)
+#define TCR_EL2_PS_44B	(4 << 16)
+#define TCR_EL2_PS_48B	(5 << 16)
 #define TCR_EL2_TG0	(1 << 14)
 #define TCR_EL2_SH0	(3 << 12)
 #define TCR_EL2_ORGN0	(3 << 10)
@@ -107,7 +112,10 @@
 #define TCR_EL2_MASK	(TCR_EL2_TG0 | TCR_EL2_SH0 | \
 			 TCR_EL2_ORGN0 | TCR_EL2_IRGN0 | TCR_EL2_T0SZ)
 
-#define TCR_EL2_FLAGS	(TCR_EL2_RES1 | TCR_EL2_PS_40B)
+/*
+ * Assign the highest possible PS.
+ */
+#define TCR_EL2_FLAGS	(TCR_EL2_RES1 | TCR_EL2_PS_48B)
 
 /* VTCR_EL2 Registers bits */
 #define VTCR_EL2_RES1		(1 << 31)
-- 
2.1.0
