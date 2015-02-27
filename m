From: keescook@chromium.org (Kees Cook)
Date: Thu, 26 Feb 2015 19:07:09 -0800
Subject: [PATCH 0/5] split ET_DYN ASLR from mmap ASLR
Message-ID: <1425006434-3106-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This separates ET_DYN ASLR from mmap ASLR, as already done on s390. The
various architectures that are already randomizing mmap (arm, arm64, mips,
powerpc, s390, and x86), have their various forms of arch_mmap_rnd()
made available via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these
architectures, arch_randomize_brk() is collapsed as well.

This is an alternative to the solutions in:
https://lkml.org/lkml/2015/2/23/442

Thanks!

-Kees
