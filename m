From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:45:14 +0100
Subject: [PATCH 58/58] arm64: Remove a redundancy in sysreg.h
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-59-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Traby <stefan@hello-penguin.com>

This is really trivial; there is a dup (1 << 16) in the code

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Stefan Traby <stefan@hello-penguin.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 040b607cb682..16e44fa9b3b6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -304,8 +304,8 @@
 #define SCTLR_ELx_M	1
 
 #define SCTLR_EL2_RES1	((1 << 4)  | (1 << 5)  | (1 << 11) | (1 << 16) | \
-			 (1 << 16) | (1 << 18) | (1 << 22) | (1 << 23) | \
-			 (1 << 28) | (1 << 29))
+			 (1 << 18) | (1 << 22) | (1 << 23) | (1 << 28) | \
+			 (1 << 29))
 
 #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M | SCTLR_ELx_A | SCTLR_ELx_C | \
 			 SCTLR_ELx_SA | SCTLR_ELx_I)
-- 
2.11.0
