From: james.morse@arm.com (James Morse)
Date: Mon, 25 Apr 2016 18:10:46 +0100
Subject: [PATCH v8 09/13] arm64: Promote KERNEL_START/KERNEL_END definitions
 to a header file
In-Reply-To: <1461604250-12789-1-git-send-email-james.morse@arm.com>
References: <1461604250-12789-1-git-send-email-james.morse@arm.com>
Message-ID: <1461604250-12789-10-git-send-email-james.morse@arm.com>
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
index 8dfe3ff7b59e..7f1a8fc20299 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -51,9 +51,6 @@
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
