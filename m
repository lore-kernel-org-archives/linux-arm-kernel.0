From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:08 +0100
Subject: [PATCH 21/51] ARM: ptrace: Add APSR_MASK definition to ptrace.h
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-22-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

APSR_MASK can be used to extract the APSR bits from the CPSR. The
comment for these definitions is also changed because it was inaccurate
as the existing defines didn't refer to any part of the APSR.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/include/asm/ptrace.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index d484871..96187ff 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -69,8 +69,9 @@
 #define PSR_c		0x000000ff	/* Control		*/
 
 /*
- * ARMv7 groups of APSR bits
+ * ARMv7 groups of PSR bits
  */
+#define APSR_MASK	0xf80f0000	/* N, Z, C, V, Q and GE flags */
 #define PSR_ISET_MASK	0x01000010	/* ISA state (J, T) mask */
 #define PSR_IT_MASK	0x0600fc00	/* If-Then execution state mask */
 #define PSR_ENDIAN_MASK	0x00000200	/* Endianness state mask */
-- 
1.7.2.5
