From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Sep 2012 13:55:19 +0200
Subject: [GIT PULL] ux500 core updates
Message-ID: <CACRpkdbcknbSqX33vVGt-d61W-pBsjdLpUAS35TdJ85BCuO=gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

these are three accumulated ux500 patches for the next merge
window with no direct relation. If you prefer three individual
pull requests for them I can do that but it seems silly, your
pick.

Plese pull this!

Yours,
Linus Walleij


The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:

  Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-core-updates

for you to fetch changes up to 0b5ea1e230432d79ce985338bbcbab1f82ae26a0:

  ARM: ux500: Provide SMSC911x fixed-regulator when not booting DT
(2012-09-04 10:14:31 +0200)

----------------------------------------------------------------
This is three ux500 core updates with no direct relation
but grouped in a pull request:
- Set the proper GIC flags to mask when suspended and
  skip wake.
- Fix a build error introduced from the PMU patch set
- Provide a fixed regulator for the Snowball when not
  using DT.

----------------------------------------------------------------
Axel Lin (1):
      ARM: ux500: Fix build error due to missing include of asm/pmu.h
in cpu-db8500.c

Lee Jones (1):
      ARM: ux500: Provide SMSC911x fixed-regulator when not booting DT

Linus Walleij (1):
      ARM: ux500: set proper GIC flags

 arch/arm/mach-ux500/Kconfig                   |  1 +
 arch/arm/mach-ux500/board-mop500-regulators.c | 15 +++++++++++++++
 arch/arm/mach-ux500/board-mop500-regulators.h |  1 +
 arch/arm/mach-ux500/board-mop500.c            | 19 +++++++++++++++++++
 arch/arm/mach-ux500/cpu-db8500.c              |  1 +
 arch/arm/mach-ux500/cpu.c                     |  2 ++
 6 files changed, 39 insertions(+)
