From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Oct 2012 21:49:34 +0000
Subject: [GIT PULL v3] ARM architecture fixes for 3.7
Message-ID: <201210192149.34864.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

you never replied to the second version of the pull request, and it hasn't
shown up in linux-next or your git tree so far. I assume you've been busy
otherwise and missed it, so here is a friendly reminder.

The contents are still identical to what we had before after I fixed up
the changeset comment for the Xen patch.

	Arnd

---
The following changes since commit 0e51793e162ca432fc5f04178cf82b80a92c2659:

  Merge branch 'for-linus' of git://git.linaro.org/people/rmk/linux-arm (2012-10-07 21:20:57 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-rmk

for you to fetch changes up to 8e7fc18b5eacc37b6e6fcf486ec4eafbfef91738:

  ARM: warnings in arch/arm/include/asm/uaccess.h (2012-10-09 20:29:07 +0200)

----------------------------------------------------------------
These bug fixes all address problems found with automated build testing.
Some of them have been around for a long time, other bugs are
regressions since the merge window.

----------------------------------------------------------------
Arnd Bergmann (9):
      ARM: kprobes: make more tests conditional
      ARM: export set_irq_flags
      ARM: Fix another build warning in arch/arm/mm/alignment.c
      ARM: export default read_current_timer
      ARM: Xen: fix initial build problems
      ARM: pass -marm to gcc by default for both C and assembler
      ARM: be really quiet when building with 'make -s'
      ARM: binfmt_flat: unused variable 'persistent'
      ARM: warnings in arch/arm/include/asm/uaccess.h

 arch/arm/Kconfig                   |    1 +
 arch/arm/Makefile                  |   13 +++++++------
 arch/arm/boot/Makefile             |   10 +++++-----
 arch/arm/include/asm/flat.h        |    2 +-
 arch/arm/include/asm/uaccess.h     |    4 ++--
 arch/arm/kernel/irq.c              |    2 ++
 arch/arm/kernel/kprobes-test-arm.c |    4 ++++
 arch/arm/lib/delay.c               |    1 +
 arch/arm/mm/alignment.c            |    4 +++-
 arch/arm/tools/Makefile            |    2 +-
 drivers/xen/Kconfig                |    2 ++
 drivers/xen/sys-hypervisor.c       |    1 +
 12 files changed, 30 insertions(+), 16 deletions(-)
