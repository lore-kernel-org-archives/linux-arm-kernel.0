From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 29 May 2017 11:28:18 +0200
Subject: [GIT PULL] Reset controller changes for v4.13
Message-ID: <1496050098.17695.31.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

please consider merging this tag for v4.13, which adds a new Gemini
reset driver, cleans up array allocation in the sti/reset-syscfg driver,
and renames the ti_syscon Kconfig symbol to align with the others.

regards
Philipp

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.13

for you to fetch changes up to 2acb037fc42b8ce5ae59a7d5db3c9b35672e3dd7:

  reset: Add a Gemini reset controller (2017-05-24 10:46:13 +0200)

----------------------------------------------------------------
Reset controller changes for v4.13

- Use devm_kcalloc to allocate the channels array in sti/reset-syscfg
- Rename the TI_SYSCON_RESET Kconfig option to RESET_TI_SYSCON for
  consistency
- Add new reset driver and DT bindings for Cortina Systems Gemini
  reset controller

----------------------------------------------------------------
Linus Walleij (2):
      reset: add DT bindings header for Gemini reset controller
      reset: Add a Gemini reset controller

Markus Elfring (1):
      reset: sti: Use devm_kcalloc() in syscfg_reset_controller_register()

Suman Anna (1):
      reset: ti_syscon: Rename TI_SYSCON_RESET to RESET_TI_SYSCON

 drivers/reset/Kconfig                            |   9 +-
 drivers/reset/Makefile                           |   3 +-
 drivers/reset/reset-gemini.c                     | 110 +++++++++++++++++++++++
 drivers/reset/sti/reset-syscfg.c                 |   6 +-
 include/dt-bindings/reset/cortina,gemini-reset.h |  36 ++++++++
 5 files changed, 158 insertions(+), 6 deletions(-)
 create mode 100644 drivers/reset/reset-gemini.c
 create mode 100644 include/dt-bindings/reset/cortina,gemini-reset.h
