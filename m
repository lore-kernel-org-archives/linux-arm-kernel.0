From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Jan 2013 19:06:37 +0100
Subject: [GIT PULL] ux500 <mach/id.h> removal
Message-ID: <CACRpkdY9BDyGQ-DiEhTiyHEYoxpGiL+H0baqsBYX_a-0upktUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

This patch set removes the use of <mach/id.h> from being broadcasted across
the kernel and blocks any further usage of cpu_is* outside of the machine.

Target is v3.9 cleanups.

It is part of our path toward single zImage.

Please pull it in! Detailed description in the tag, MFD hunk ACKed by
Samuel Ortiz.

Yours,
Linus Walleij

The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-no-idh

for you to fetch changes up to 7a4f26097d389c16c9956bc03b81532698d97d64:

  ARM: ux500: de-globalize <mach/id.h> (2013-01-29 18:47:37 +0100)

----------------------------------------------------------------
Removal of the <mach/id.h> include from ux500
- First an ACKed MFD patch deleting the only consumer
  of these cpu_is* functions outside of mach-ux500
- Introduce a new local cpu_is_u8580() in this patch
  set to avoid clashing with other patch sets.
- Finally de-globalize <mach/id.h>.

----------------------------------------------------------------
Linus Walleij (2):
      mfd: prcmu: delete pin control helpers
      ARM: ux500: de-globalize <mach/id.h>

Maxime Coquelin (1):
      ARM: ux500: Introduce cpu_is_u8580()

 arch/arm/mach-ux500/board-mop500-uib.c      |  1 +
 arch/arm/mach-ux500/cache-l2x0.c            |  3 +-
 arch/arm/mach-ux500/cpu-db8500.c            |  2 +
 arch/arm/mach-ux500/cpu.c                   |  1 +
 arch/arm/mach-ux500/id.c                    |  2 +
 arch/arm/mach-ux500/{include/mach => }/id.h | 21 +++++++-
 arch/arm/mach-ux500/include/mach/hardware.h |  1 -
 arch/arm/mach-ux500/platsmp.c               |  3 ++
 arch/arm/mach-ux500/timer.c                 |  2 +
 drivers/cpufreq/db8500-cpufreq.c            |  3 --
 drivers/mfd/db8500-prcmu.c                  | 17 +++---
 include/linux/mfd/db8500-prcmu.h            |  6 ---
 include/linux/mfd/dbx500-prcmu.h            | 81 -----------------------------
 13 files changed, 39 insertions(+), 104 deletions(-)
 rename arch/arm/mach-ux500/{include/mach => }/id.h (85%)
