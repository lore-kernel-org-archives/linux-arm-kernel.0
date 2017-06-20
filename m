From: stefan@hello-penguin.com (Stefan Traby)
Date: Tue, 20 Jun 2017 15:30:42 +0200
Subject: [PATCH] arm64: remove a redundancy in sysreg.h
Message-ID: <20170620133042.mlqgpx5vddgvoe6k@hello-penguin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is really trivial; there is a dup
(1 << 16) in the code

Signed-off-by: Stefan Traby <stefan@hello-penguin.com>
---
 arch/arm64/include/asm/sysreg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 2d3e155b185f..580965129fea 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -139,8 +139,8 @@
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


-- 

  ciao - 
    Stefan
