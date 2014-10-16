From: keescook@chromium.org (Kees Cook)
Date: Thu, 16 Oct 2014 14:45:42 -0700
Subject: [PULL v2] ARM ro-nx tree (next)
Message-ID: <20141016214542.GA12587@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull this series for ro-nx support on ARM for next.

Thanks!

-Kees

The following changes since commit bfe01a5ba2490f299e1d2d5508cbbbadd897bbe9:

  Linux 3.17 (2014-10-05 12:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/ronx-next

for you to fetch changes up to 80d6b0c2eed2a504f6740cd1f5ea76dc50abfc4d:

  ARM: mm: allow text and rodata sections to be read-only (2014-10-16 14:38:54 -0700)

----------------------------------------------------------------
generic fixmaps
ARM support for CONFIG_DEBUG_RODATA

----------------------------------------------------------------
Doug Anderson (1):
      arm: kgdb: Handle read-only text / modules

Kees Cook (3):
      arm: fixmap: implement __set_fixmap()
      ARM: mm: allow non-text sections to be non-executable
      ARM: mm: allow text and rodata sections to be read-only

Mark Salter (1):
      arm: use generic fixmap.h

Nikolay Borisov (1):
      ARM: kexec: Make .text R/W in machine_kexec

Rabin Vincent (1):
      arm: use fixmap for text patching when text is RO

Rob Herring (1):
      ARM: expand fixmap region to 3MB

 Documentation/arm/memory.txt      |   2 +-
 arch/arm/include/asm/cacheflush.h |  10 +++
 arch/arm/include/asm/fixmap.h     |  31 ++++----
 arch/arm/kernel/Makefile          |   2 +-
 arch/arm/kernel/ftrace.c          |  19 +++++
 arch/arm/kernel/jump_label.c      |   2 +-
 arch/arm/kernel/kgdb.c            |  29 ++++++++
 arch/arm/kernel/machine_kexec.c   |   9 ++-
 arch/arm/kernel/patch.c           |  92 ++++++++++++++++++-----
 arch/arm/kernel/patch.h           |  12 ++-
 arch/arm/kernel/vmlinux.lds.S     |  19 +++++
 arch/arm/mm/Kconfig               |  21 ++++++
 arch/arm/mm/highmem.c             |  15 ++--
 arch/arm/mm/init.c                | 149 +++++++++++++++++++++++++++++++++++++-
 arch/arm/mm/mmu.c                 |  39 +++++++++-
 15 files changed, 394 insertions(+), 57 deletions(-)

-- 
Kees Cook
Chrome OS Security
