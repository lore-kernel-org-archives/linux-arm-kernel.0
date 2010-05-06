From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 06 May 2010 15:12:38 +0100
Subject: [PATCH] ARM: Declare __copy_to_user_std as a function using ENDPROC
Message-ID: <20100506141238.4396.8055.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for Thumb-2 kernel builds, otherwise the compiler
generates branches into ARM mode to this function.

Reported-by: Kyungmin Park <kmpark@infradead.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/lib/copy_to_user.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index 1a71e15..5941fbc 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -93,6 +93,7 @@ WEAK(__copy_to_user)
 #include "copy_template.S"
 
 ENDPROC(__copy_to_user)
+ENDPROC(__copy_to_user_std)
 
 	.section .fixup,"ax"
 	.align 0
