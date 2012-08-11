From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Aug 2012 12:04:31 +0100
Subject: [PATCH 1/7] ARM: opcodes: add __ERET/__MSR_ELR_HYP instruction
 encoding
In-Reply-To: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
References: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1344683077-12841-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling boot from HYP mode requires the use of some more
virt-specific instructions ("eret" and "msr elr_hyp, reg").

Add the necessary encoding to asm/opcode-virt.h.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/opcodes-virt.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/opcodes-virt.h b/arch/arm/include/asm/opcodes-virt.h
index b85665a..efcfdf9 100644
--- a/arch/arm/include/asm/opcodes-virt.h
+++ b/arch/arm/include/asm/opcodes-virt.h
@@ -26,4 +26,14 @@
 	0xF7E08000 | (((imm16) & 0xF000) << 4) | ((imm16) & 0x0FFF)	\
 )
 
+#define __ERET	__inst_arm_thumb32(					\
+	0xE160006E,							\
+	0xF3DE8F00							\
+)
+
+#define __MSR_ELR_HYP(regnum)	__inst_arm_thumb32(			\
+	0xE12EF300 | regnum,						\
+	0xF3808E30 | (regnum << 16)					\
+)
+
 #endif /* ! __ASM_ARM_OPCODES_VIRT_H */
-- 
1.7.8.6
