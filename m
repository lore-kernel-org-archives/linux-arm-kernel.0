From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Mar 2015 18:38:11 +0100
Subject: [RFT/RFC PATCH 5/6] ARM: move the .idmap.text section closer to
 .head.text
In-Reply-To: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426181892-15440-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the .idmap.text section closer to .head.text, so that
relative branches are less likely to go out of range if the kernel
text gets bigger.

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
