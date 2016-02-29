From: james.morse@arm.com (James Morse)
Date: Mon, 29 Feb 2016 17:20:18 +0000
Subject: [PATCH v6 09/14] arm64: Promote KERNEL_START/KERNEL_END definitions
 to a header file
In-Reply-To: <1456766423-1554-1-git-send-email-james.morse@arm.com>
References: <1456766423-1554-1-git-send-email-james.morse@arm.com>
Message-ID: <1456766423-1554-10-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KERNEL_START and KERNEL_END are useful outside head.S, move them to a
header file.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/memory.h | 3 +++
 arch/arm64/kernel/head.S        | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 5f8667a99e41..22c8c53d4d65 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -71,6 +71,9 @@
 
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
 
+#define KERNEL_START      _text
+#define KERNEL_END        _end
+
 /*
  * The size of the KASAN shadow region. This should be 1/8th of the
  * size of the entire kernel virtual address space.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7526a777384c..7e4f840e1de7 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -50,9 +50,6 @@
 #error TEXT_OFFSET must be less than 2MB
 #endif
 
-#define KERNEL_START	_text
-#define KERNEL_END	_end
-
 /*
  * Kernel startup entry point.
  * ---------------------------
-- 
2.7.0
