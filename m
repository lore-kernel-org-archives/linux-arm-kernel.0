From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 20 Jan 2017 18:26:10 +0100
Subject: [GIT PULL] Reset controller changes for v4.11
Message-ID: <1484933170.2897.76.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

Please consider merging this tag which adds reset controller drivers for
Hi3660 and ZX2967 SoCs and adds SD reset support for LD11 SoCs. It makes
the API describe optional and not present reset controls as NULL
pointers, which will allow some drivers to simplify their return value
handling. There also is a ti_syscon status return value fix, a typo fix,
and some constification.

regards
Philipp

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.pengutronix.de/pza/linux tags/reset-for-4.11

for you to fetch changes up to bb475230b8e59a547ab66ac3b02572df21a580e9:

  reset: make optional functions really optional (2017-01-20 10:36:15 +0100)

----------------------------------------------------------------
Reset controller changes for v4.11

- fix ti_syscon reset_status reporting
- add Hisilicon Hi3660 reset controller driver
- add ZTE ZX2967 reset controller driver
- add LD11 SD-reset block to uniphier reset controller driver
- typo and correctness fixes
- make reset_control_get variants return NULL instead of an
  error for optional, not specified resets and have the other
  reset API functions silently ignore rstc == NULL parameters.

----------------------------------------------------------------
Baoyou Xie (3):
      dt: bindings: add documentation for zx2967 family reset controller
      MAINTAINERS: add zx2967 reset controller driver to ARM ZTE architecture
      reset: zx2967: add reset controller driver for ZTE's zx2967 family

Bhumika Goyal (1):
      reset: constify reset_control_ops structures

Jiancheng Xue (1):
      reset: ti_syscon: fix a ti_syscon_reset_status issue

Masahiro Yamada (1):
      reset: uniphier: add compatible string for LD11 SD-reset block

Ramiro Oliveira (2):
      reset: Change shared flag from int to bool
      reset: make optional functions really optional

Suman Anna (1):
      Documentation: dt: reset: Revise typos in TI syscon reset example

Zhangfei Gao (2):
      dt-bindings: Document the hi3660 reset bindings
      reset: hisilicon: add reset-hi3660

 .../bindings/reset/hisilicon,hi3660-reset.txt      |  43 +++++++
 .../devicetree/bindings/reset/ti-syscon-reset.txt  |   8 +-
 .../devicetree/bindings/reset/uniphier-reset.txt   |  47 ++++----
 .../devicetree/bindings/reset/zte,zx2967-reset.txt |  20 ++++
 MAINTAINERS                                        |   2 +
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  53 +++++++--
 drivers/reset/hisilicon/Kconfig                    |   7 ++
 drivers/reset/hisilicon/Makefile                   |   1 +
 drivers/reset/hisilicon/reset-hi3660.c             | 126 +++++++++++++++++++++
 drivers/reset/reset-ti-syscon.c                    |   6 +-
 drivers/reset/reset-uniphier.c                     |   4 +
 drivers/reset/reset-zx2967.c                       | 106 +++++++++++++++++
 include/linux/reset.h                              |  45 ++++----
 15 files changed, 414 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 create mode 100644 drivers/reset/hisilicon/reset-hi3660.c
 create mode 100644 drivers/reset/reset-zx2967.c
