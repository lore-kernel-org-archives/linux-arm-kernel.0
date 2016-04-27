From: james.morse@arm.com (James Morse)
Date: Wed, 27 Apr 2016 17:47:09 +0100
Subject: [PATCH v9 10/14] arm64: Promote KERNEL_START/KERNEL_END definitions
 to a header file
In-Reply-To: <1461775633-29715-1-git-send-email-james.morse@arm.com>
References: <1461775633-29715-1-git-send-email-james.morse@arm.com>
Message-ID: <1461775633-29715-11-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KERNEL_START and KERNEL_END are useful outside head.S, move them to a
header file.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/memory.h | 3 +++
 arch/arm64/kernel/head.S        | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f412f502ccdd..72a3025bb583 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -87,6 +87,9 @@
 
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
 
+#define KERNEL_START      _text
+#define KERNEL_END        _end
+
 /*
  * The size of the KASAN shadow region. This should be 1/8th of the
  * size of the entire kernel virtual address space.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0674384cfc74..564c340cef03 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -52,9 +52,6 @@
 #error TEXT_OFFSET must be less than 2MB
 #endif
 
-#define KERNEL_START	_text
-#define KERNEL_END	_end
-
 /*
  * Kernel startup entry point.
  * ---------------------------
-- 
2.8.0.rc3
