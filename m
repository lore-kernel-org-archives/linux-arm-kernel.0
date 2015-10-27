From: james.morse@arm.com (James Morse)
Date: Tue, 27 Oct 2015 17:29:18 +0000
Subject: [PATCH v2 09/11] arm64: Promote KERNEL_START/KERNEL_END definitions
 to a header file
In-Reply-To: <1445966960-31724-1-git-send-email-james.morse@arm.com>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Message-ID: <1445966960-31724-10-git-send-email-james.morse@arm.com>
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
index 6b4c3ad75a2a..1383491f3db4 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -72,6 +72,9 @@
 #error Top of 64-bit user space clashes with start of module space
 #endif
 
+#define KERNEL_START      _text
+#define KERNEL_END        _end
+
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cf4e0bdf6533..537406273f96 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -55,9 +55,6 @@
 #define TABLE_SHIFT	PUD_SHIFT
 #endif
 
-#define KERNEL_START	_text
-#define KERNEL_END	_end
-
 /*
  * Initial memory map attributes.
  */
-- 
2.1.4
