From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 19 Oct 2017 11:26:38 +0200
Subject: [GIT PULL] Reset controller changes for v4.15
Message-ID: <1508405198.7665.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc-maintainers,

please consider merging this tag for v4.15. It adds ARC AX10x reset
support, merged from a separate branch for synchronisation with the ARC
tree, Stratix10 reset support, Meson GX reset level controls, and PXs3
and ethernet reset controls for Uniphier.
The socfpga, stm32, (most of) sunxi, and zx2967 drivers are merged into
a common simple-reset driver.

regards
Philipp

The following changes since commit f450f28e70a2378d9d6ded0932fe480055888cfa:

  reset: socfpga: fix for 64-bit compilation (2017-10-04 10:29:44 +0200)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.15

for you to fetch changes up to 542befbb18056c4fda7b458aa6146a52b2fd389c:

  Merge branch 'reset/arc' into reset/next (2017-10-18 15:59:30 +0200)

----------------------------------------------------------------
Reset controller changes for v4.15

- add ARC AX10x support,
  merged from a separate branch that is also included in the ARC tree
- add Stratix10 support via socfpga
- unify socfpga, stm32, sunxi, and zx2967 into simple-reset driver
- add Meson GX reset level control
- add Uniphier PXs3 and ethernet reset controls

----------------------------------------------------------------
Dinh Nguyen (1):
      reset: socfpga: build the reset-socfpga for Stratix10 SOC

Eugeniy Paltsev (1):
      ARC: reset: introduce AXS10x reset driver

Kunihiko Hayashi (1):
      reset: uniphier: add ethernet reset control support

Masahiro Yamada (1):
      reset: uniphier: add PXs3 reset data

Neil Armstrong (2):
      reset: meson: add level reset support for GX SoC family
      reset: meson: remove unneeded check in meson_reset_reset

Philipp Zabel (6):
      reset: add reset-simple to unify socfpga, stm32, sunxi, and zx2967
      reset: sunxi: use reset-simple driver
      reset: socfpga: use the reset-simple driver
      reset: stm32: use the reset-simple driver
      reset: zx2967: use the reset-simple driver
      Merge branch 'reset/arc' into reset/next

Sean Wang (1):
      reset: mediatek: add reset controller dt-bindings required header for MT7622 SoC

 .../bindings/reset/snps,axs10x-reset.txt           |  33 ++++
 .../devicetree/bindings/reset/uniphier-reset.txt   |   3 +
 MAINTAINERS                                        |   7 +-
 drivers/reset/Kconfig                              |  30 ++--
 drivers/reset/Makefile                             |   5 +-
 drivers/reset/reset-axs10x.c                       |  83 +++++++++
 drivers/reset/reset-meson.c                        |  65 ++++++-
 drivers/reset/reset-simple.c                       | 186 +++++++++++++++++++++
 drivers/reset/reset-simple.h                       |  45 +++++
 drivers/reset/reset-socfpga.c                      | 157 -----------------
 drivers/reset/reset-stm32.c                        | 108 ------------
 drivers/reset/reset-sunxi.c                        | 104 +-----------
 drivers/reset/reset-uniphier.c                     |  30 ++++
 drivers/reset/reset-zx2967.c                       |  99 -----------
 include/dt-bindings/reset/mt7622-reset.h           |  94 +++++++++++
 15 files changed, 561 insertions(+), 488 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/snps,axs10x-reset.txt
 create mode 100644 drivers/reset/reset-axs10x.c
 create mode 100644 drivers/reset/reset-simple.c
 create mode 100644 drivers/reset/reset-simple.h
 delete mode 100644 drivers/reset/reset-socfpga.c
 delete mode 100644 drivers/reset/reset-stm32.c
 delete mode 100644 drivers/reset/reset-zx2967.c
 create mode 100644 include/dt-bindings/reset/mt7622-reset.h
