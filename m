From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:56:57 +0000
Subject: [PATCH v6 06/24] arm64: ptrace: Provide definitions for PMR values
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-7-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce fixed values for PMR that are going to be used to mask and
unmask interrupts by priority. These values are chosent in such a way
that a single bit (GIC_PMR_UNMASKED_BIT) encodes the information whether
interrupts are masked or not.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/ptrace.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index fce22c4..ce6998c 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -25,6 +25,12 @@
 #define CurrentEL_EL1		(1 << 2)
 #define CurrentEL_EL2		(2 << 2)
 
+/* PMR values used to mask/unmask interrupts */
+#define GIC_PRIO_IRQON		0xf0
+#define GIC_PRIO_STATUS_SHIFT	6
+#define GIC_PRIO_STATUS_BIT	(1 << GIC_PRIO_STATUS_SHIFT)
+#define GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON ^ GIC_PRIO_STATUS_BIT)
+
 /* Additional SPSR bits not exposed in the UABI */
 #define PSR_IL_BIT		(1 << 20)
 
-- 
1.9.1
