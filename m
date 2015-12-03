From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 03 Dec 2015 15:59:21 +0100
Subject: [GIT PULL v2] Reset controller changes for v4.5
Message-ID: <1449154761.3339.40.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

This tag includes co-processor reset support for STi, Hi6220 reset
support, ath79 restart support, and a few accumulated fixes. It sits on
top of the older tag "reset-for-4.5", so the changes from the previous
pull request are included.

best regards
Philipp

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.5-2

for you to fetch changes up to ba64e27e9d3c558549f765869c6a471114c0f328:

  reset: ath79: Add system restart support (2015-11-25 10:49:58 +0100)

----------------------------------------------------------------
Reset controller changes for v4.5 v2

- oftree support for getting reset devices by index
- fixed return value consistency of of_reset_control_get
- added support for STi co-processor resets
- added STi status callback
- added HiSilicon Hi6220 reset driver
- added ath79 system restart support
- various fixes

----------------------------------------------------------------
Alban Bedel (2):
      reset: Fix of_reset_control_get() for consistent return values
      reset: ath79: Add system restart support

Chen Feng (3):
      reset: hisilicon: document hisi-hi6220 reset controllers bindings
      reset: hi6220: Reset driver for hisilicon hi6220 SoC
      arm64: dts: Add reset dts config for Hisilicon Hi6220 SoC

Lee Jones (3):
      ARM: STi: Add DT defines for co-processor reset lines
      reset: sti: Add support for resetting co-processors
      reset: sti: Provide ops .status() call-back

Masahiro Yamada (2):
      reset: remove redundant $(CONFIG_RESET_CONTROLLER) from Makefile
      reset: check return value of reset_controller_register()

Philipp Zabel (4):
      reset: sti: add a missing blank line after declaration
      reset: sunxi: mark the of_device_id array as __initconst
      reset: use ENOTSUPP instead of ENOSYS
      reset: remove unused device pointer from struct reset_control

Vince Hsu (1):
      reset: add of_reset_control_get_by_index()

 .../bindings/reset/hisilicon,hi6220-reset.txt      |  34 +++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   1 +
 drivers/reset/Kconfig                              |   1 +
 drivers/reset/Makefile                             |   3 +-
 drivers/reset/core.c                               |  60 +++++++-----
 drivers/reset/hisilicon/Kconfig                    |   5 +
 drivers/reset/hisilicon/Makefile                   |   1 +
 drivers/reset/hisilicon/hi6220_reset.c             | 108 +++++++++++++++++++++
 drivers/reset/reset-ath79.c                        |  30 +++++-
 drivers/reset/reset-berlin.c                       |   4 +-
 drivers/reset/reset-socfpga.c                      |   3 +-
 drivers/reset/reset-sunxi.c                        |   5 +-
 drivers/reset/reset-zynq.c                         |   3 +-
 drivers/reset/sti/reset-stih407.c                  |   5 +
 drivers/reset/sti/reset-syscfg.c                   |  27 +++++-
 include/dt-bindings/reset/hisi,hi6220-resets.h     |  67 +++++++++++++
 include/dt-bindings/reset/stih407-resets.h         |   4 +
 include/linux/reset.h                              |  17 +++-
 18 files changed, 338 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
 create mode 100644 drivers/reset/hisilicon/Kconfig
 create mode 100644 drivers/reset/hisilicon/Makefile
 create mode 100644 drivers/reset/hisilicon/hi6220_reset.c
 create mode 100644 include/dt-bindings/reset/hisi,hi6220-resets.h
