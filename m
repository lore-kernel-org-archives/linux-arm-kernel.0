From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:22:54 +0200
Subject: [GIT PULL 0/9] ARM architecture fixes for 3.7
Message-ID: <1349796183-30648-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: <arnd@arndb.de>

Hi Russell,

Here are some patches that belong into your domain, I hope you can
just send the lot to Linus the next time you send other patches.

These bug fixes all address problems found with automated build testing.
Some of them have been around for a long time, other bugs are
regressions since the merge window.

	Arnd

The following changes since commit 0e51793e162ca432fc5f04178cf82b80a92c2659:

  Merge branch 'for-linus' of git://git.linaro.org/people/rmk/linux-arm (2012-10-07 21:20:57 +0900)

are available in the git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-rmk

for you to fetch changes up to 93c6cee8e966ceb78a08e6a69a3afc948b74d254:

  ARM: warnings in arch/arm/include/asm/uaccess.h (2012-10-09 17:07:44 +0200)

----------------------------------------------------------------
Arnd Bergmann (9):
      ARM: kprobes: make more tests conditional
      ARM: export set_irq_flags
      ARM: Fix another build warning in arch/arm/mm/alignment.c
      ARM: export default read_current_timer
      ARM: Xen: fix initial build problems:
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

Cc: bryan.wu at canonical.com
Cc: catalin.marinas at arm.com
Cc: dave.martin at linaro.org
Cc: jeremy at goop.org
Cc: jonathan.austin at arm.com
Cc: konrad.wilk at oracle.com
Cc: leif.lindholm at arm.com
Cc: linus.walleij at linaro.org
Cc: damm at opensource.se
Cc: mmarek at suse.cz
Cc: rjw at sisk.pl
Cc: rmk+kernel at arm.linux.org.uk
Cc: stefano.stabellini at eu.citrix.com
Cc: sboyd at codeaurora.org
Cc: tglx at linutronix.de
Cc: will.deacon at arm.com
Cc: xen-devel at lists.xensource.com
