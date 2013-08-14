From: behanw@converseincode.com (behanw at converseincode.com)
Date: Wed, 14 Aug 2013 17:37:41 -0400
Subject: [PATCH] ARM: LLVMLinux: Change "extern inline" to "gnu_inline" in ARM
 ftrace.h
In-Reply-To: <1376516261-2071-1-git-send-email-behanw@converseincode.com>
References: <1376516261-2071-1-git-send-email-behanw@converseincode.com>
Message-ID: <1376516261-2071-2-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Charlebois <charlebm@gmail.com>

With compilers which follow the C99 standard (like modern versions of gcc and
clang), "extern inline" does the wrong thing (emits code for an externally
linkable version of the inline function). In this case using the gnu_inline
attribute makes inline do the right thing on gcc and on clang.

Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
---
 arch/arm/include/asm/ftrace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index f89515a..fb7fdc4 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -45,7 +45,8 @@ void *return_address(unsigned int);
 
 #else
 
-extern inline void *return_address(unsigned int level)
+extern inline __attribute__((gnu_inline))
+void *return_address(unsigned int level)
 {
 	return NULL;
 }
-- 
1.8.1.2
