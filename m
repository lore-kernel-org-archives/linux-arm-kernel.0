From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Mar 2015 13:07:29 +0100
Subject: [PATCH v2 5/8] ARM: move the .idmap.text section closer to .head.text
In-Reply-To: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426248452-4773-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the .idmap.text section closer to .head.text, so that
relative branches are less likely to go out of range if the kernel
text gets bigger.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index e3b9403bd2d6..2e7b2220ef5f 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -103,6 +103,7 @@ SECTIONS
 
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
+			IDMAP_TEXT
 			__exception_text_start = .;
 			*(.exception.text)
 			__exception_text_end = .;
@@ -111,7 +112,6 @@ SECTIONS
 			SCHED_TEXT
 			LOCK_TEXT
 			KPROBES_TEXT
-			IDMAP_TEXT
 #ifdef CONFIG_MMU
 			*(.fixup)
 #endif
-- 
1.8.3.2
