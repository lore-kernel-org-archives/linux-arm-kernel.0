From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 14 Mar 2016 16:53:01 +0000
Subject: [RFC PATCH 02/12] arm64: kvm: Fix {V}TCR_EL2_TG0 mask
In-Reply-To: <1457974391-28456-1-git-send-email-suzuki.poulose@arm.com>
References: <1457974391-28456-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1457974391-28456-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

{V}TCR_EL2_TG0 is a 2bit wide field, where:

 00 - 4K
 01 - 64K
 10 - 16K

But we use only 1 bit, which has worked well so far since
we never cared about 16K. Fix it for 16K support.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: kvmarm at lists.cs.columbia.edu
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index d201d4b..b7d61e4 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -99,7 +99,7 @@
 #define TCR_EL2_TBI	(1 << 20)
 #define TCR_EL2_PS	(7 << 16)
 #define TCR_EL2_PS_40B	(2 << 16)
-#define TCR_EL2_TG0	(1 << 14)
+#define TCR_EL2_TG0	(3 << 14)
 #define TCR_EL2_SH0	(3 << 12)
 #define TCR_EL2_ORGN0	(3 << 10)
 #define TCR_EL2_IRGN0	(3 << 8)
@@ -110,7 +110,7 @@
 /* VTCR_EL2 Registers bits */
 #define VTCR_EL2_RES1		(1 << 31)
 #define VTCR_EL2_PS_MASK	(7 << 16)
-#define VTCR_EL2_TG0_MASK	(1 << 14)
+#define VTCR_EL2_TG0_MASK	(3 << 14)
 #define VTCR_EL2_TG0_4K		(0 << 14)
 #define VTCR_EL2_TG0_64K	(1 << 14)
 #define VTCR_EL2_SH0_MASK	(3 << 12)
-- 
1.7.9.5
