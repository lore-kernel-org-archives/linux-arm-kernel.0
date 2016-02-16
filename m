From: james.morse@arm.com (James Morse)
Date: Tue, 16 Feb 2016 15:49:21 +0000
Subject: [PATCH v5 09/15] arm64: Promote KERNEL_START/KERNEL_END definitions
 to a header file
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Message-ID: <1455637767-31561-10-git-send-email-james.morse@arm.com>
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
index 3239e4d78e0d..04de97734f06 100644
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
index 6fad2f814ecf..410a2dc04775 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -48,9 +48,6 @@
 #error TEXT_OFFSET must be less than 2MB
 #endif
 
-#define KERNEL_START	_text
-#define KERNEL_END	_end
-
 /*
  * Kernel startup entry point.
  * ---------------------------
-- 
2.6.2
