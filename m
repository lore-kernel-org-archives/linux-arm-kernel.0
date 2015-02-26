From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 26 Feb 2015 15:03:57 -0800
Subject: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
In-Reply-To: <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
Message-ID: <20150226150357.b9343de08c96cb366d7e1d56@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Feb 2015 14:38:15 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> Does that __weak trick even work?

Nope.

--- a/fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix
+++ a/fs/binfmt_elf.c
@@ -2307,10 +2307,10 @@ unsigned long __weak mmap_rnd(void)
 }
 
 /*
- * Not all architectures use randomize_et_dyn(), so use __weak to let the
- * linker omit it from vmlinux
+ * Not all architectures use randomize_et_dyn(), but there doesn't seem to be
+ * a compile-time way of avoiding its generation.
  */
-unsigned long __weak randomize_et_dyn(unsigned long base)
+unsigned long randomize_et_dyn(unsigned long base)
 {
 	unsigned long ret;
 
_
