From: keescook@chromium.org (Kees Cook)
Date: Mon,  2 Mar 2015 16:19:43 -0800
Subject: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
Message-ID: <1425341988-1599-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
ASLR from mmap ASLR, as already done on s390. The architectures
that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
and x86), have their various forms of arch_mmap_rnd() made available
via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
arch_randomize_brk() is collapsed as well.

This is an alternative to the solutions in:
https://lkml.org/lkml/2015/2/23/442

Thanks!

-Kees

[1] http://cybersecurity.upv.es/attacks/offset2lib/offset2lib.html

---
v2:
- verbosified the commit logs, especially 4/5 (akpm)
