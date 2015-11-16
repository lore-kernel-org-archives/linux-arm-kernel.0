From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 16 Nov 2015 17:45:09 +0100
Subject: [GIT PULL] Reset controller changes for v4.5
Message-ID: <1447692309.3312.26.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

This tag includes co-processor reset support for STi and a few accumulated fixes.

regards
Philipp

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.5

for you to fetch changes up to d1f15aa09558d00ed23168686156f7341f9d9d86:

  reset: check return value of reset_controller_register() (2015-11-16 09:23:47 +0100)

----------------------------------------------------------------
Reset controller changes for v4.5

- oftree support for getting reset devices by index
- fixed return value consistency of of_reset_control_get
- added support for STi co-processor resets
- added STi status callback
- various fixes

----------------------------------------------------------------
Alban Bedel (1):
      reset: Fix of_reset_control_get() for consistent return values

Lee Jones (3):
      ARM: STi: Add DT defines for co-processor reset lines
      reset: sti: Add support for resetting co-processors
      reset: sti: Provide ops .status() call-back

Masahiro Yamada (2):
      reset: remove redundant $(CONFIG_RESET_CONTROLLER) from Makefile
      reset: check return value of reset_controller_register()

Philipp Zabel (3):
      reset: sti: add a missing blank line after declaration
      reset: sunxi: mark the of_device_id array as __initconst
      reset: use ENOTSUPP instead of ENOSYS

Vince Hsu (1):
      reset: add of_reset_control_get_by_index()

 drivers/reset/Makefile                     |  2 +-
 drivers/reset/core.c                       | 51 +++++++++++++++++++++---------
 drivers/reset/reset-berlin.c               |  4 +--
 drivers/reset/reset-socfpga.c              |  3 +-
 drivers/reset/reset-sunxi.c                |  5 ++-
 drivers/reset/reset-zynq.c                 |  3 +-
 drivers/reset/sti/reset-stih407.c          |  5 +++
 drivers/reset/sti/reset-syscfg.c           | 27 +++++++++++++++-
 include/dt-bindings/reset/stih407-resets.h |  4 +++
 include/linux/reset.h                      | 17 +++++++---
 10 files changed, 90 insertions(+), 31 deletions(-)
