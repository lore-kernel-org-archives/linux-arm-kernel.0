From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 01 Jun 2016 18:39:39 +0200
Subject: [GIT PULL] Reset controller changes for v4.8
Message-ID: <1464799179.3522.62.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

This tag contains the devm_reset_controller_register call and a series
of patches to make use of it, and a patch to fix all reset_control_get
stubs to return -ENOTSUPP when reset control support is disabled, for
consistency.

regards
Philipp

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.8

for you to fetch changes up to 168d7c4e8bb25c076ed8be67fcca84f5dcd0b2c6:

  reset: Return -ENOTSUPP when not configured (2016-06-01 08:21:08 +0200)

----------------------------------------------------------------
Reset controller changes for v4.8

- add devm_reset_controller_register API to get rid of a good
  amount of boilerplate across reset drivers.
- move reset controller Kconfig options into a sub-menu
- fix inconsistent return values, let all reset_control_get
  stubs return -ENOTSUPP

----------------------------------------------------------------
John Youn (1):
      reset: Return -ENOTSUPP when not configured

Masahiro Yamada (7):
      reset: add devm_reset_controller_register API
      reset: ath79: use devm_reset_controller_register()
      reset: pistachio: use devm_reset_controller_register()
      reset: sunxi: use devm_reset_controller_register()
      reset: socfpga: use devm_reset_controller_register()
      reset: zynq: use devm_reset_controller_register()
      reset: fix Kconfig menu to include reset drivers in sub-menu

Neil Armstrong (1):
      reset: oxnas: Use devm register API and get rid of platform remove

 Documentation/driver-model/devres.txt |  4 ++++
 drivers/reset/Kconfig                 |  4 ++++
 drivers/reset/core.c                  | 37 +++++++++++++++++++++++++++++++++++
 drivers/reset/reset-ath79.c           |  3 +--
 drivers/reset/reset-oxnas.c           | 12 +-----------
 drivers/reset/reset-pistachio.c       | 12 +-----------
 drivers/reset/reset-socfpga.c         | 12 +-----------
 drivers/reset/reset-sunxi.c           | 12 +-----------
 drivers/reset/reset-zynq.c            | 12 +-----------
 drivers/reset/sti/Kconfig             |  1 -
 include/linux/reset-controller.h      |  4 ++++
 include/linux/reset.h                 |  4 ++--
 12 files changed, 57 insertions(+), 60 deletions(-)
