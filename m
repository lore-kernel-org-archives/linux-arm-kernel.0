From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 May 2015 15:23:49 +0200
Subject: [GIT PULL] ux500 cleanups for v4.2
Message-ID: <CACRpkdbRXN4bBWdqpMVRJ6bqqKrkO-8ssfWmHfbguNjjbjGpGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

this is a pull request for some additional cleanups requested by Arnd
in this message:
http://marc.info/?l=linux-arm-kernel&m=143151859309482&w=2

Please pull this into next/cleanup where the dependent patch is.
A patch from the next/dt, commit 487934109d33e1749d3034899685111bca6ffd0b
"ARM: ux500: add SCU and WD to device tree" is needed for this to
work but since I regard all DT work as essentially orthogonal I rely on
the two to merge up in the end and work nicely.

Please pull this into next/cleanup!

Yours,
Linus Walleij

The following changes since commit bf300afa3ff388d659381d7b363d4c1d560c943e:

  Merge tag 'tegra-for-4.2-cleanup' of
git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into
next/cleanup (2015-05-13 17:52:57 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-cleanup-v4.2

for you to fetch changes up to 1da4d13912e773523ef095fa05704d6962babe90:

  ARM: ux500: delete static resource defines (2015-05-18 15:08:15 +0200)

----------------------------------------------------------------
Ux500 cleanups for the v4.2 merge window.

----------------------------------------------------------------
Linus Walleij (10):
      ARM: ux500: delete UART static map
      ARM: ux500: remove static maps from platsmp
      ARM: ux500: remap BB offset dynamically
      ARM: ux500: get SCU base from device tree
      ARM: ux500: get rid of static GIC dist base
      ARM: ux500: get rid of SCU and backupram static maps
      ARM: ux500: kill off L2CC static map
      ARM: ux500: look up PRCMU resource from DT
      ARM: ux500: rename ux500_map_io
      ARM: ux500: delete static resource defines

 arch/arm/mach-ux500/cache-l2x0.c | 11 ++++++++-
 arch/arm/mach-ux500/cpu-db8500.c | 49 ++++++----------------------------------
 arch/arm/mach-ux500/cpu.c        | 20 ++++++++++------
 arch/arm/mach-ux500/id.c         |  2 +-
 arch/arm/mach-ux500/platsmp.c    | 35 ++++++++++++----------------
 arch/arm/mach-ux500/pm.c         | 15 ++++++++++--
 arch/arm/mach-ux500/setup.h      | 16 +------------
 7 files changed, 59 insertions(+), 89 deletions(-)
