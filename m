From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Oct 2012 18:40:24 +0000
Subject: [GIT PULL 0/9] ARM architecture fixes for 3.7
In-Reply-To: <20121009160814.GH4625@n2100.arm.linux.org.uk>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <20121009160814.GH4625@n2100.arm.linux.org.uk>
Message-ID: <201210091840.25176.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 October 2012, Russell King - ARM Linux wrote:
> 
> On Tue, Oct 09, 2012 at 05:22:54PM +0200, Arnd Bergmann wrote:
> > Here are some patches that belong into your domain, I hope you can
> > just send the lot to Linus the next time you send other patches.
> > 
> > These bug fixes all address problems found with automated build testing.
> > Some of them have been around for a long time, other bugs are
> > regressions since the merge window.
> 
> Apart from the sliced off comment in one commit (which XEN people need
> to confirm they're happy with the final version), I think these are
> otherwise fine... I'll hold off pulling them until that can be fixed.

Fixed that now, and I also added the Acks that I got in the meantime,
changed the dependency from Xen on (CPU_v7 && !CPU_V6), and edited the
description for patch 6 as Dave suggested.

	Arnd

8<---
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
