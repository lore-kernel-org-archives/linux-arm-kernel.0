From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 08 Mar 2017 10:26:17 +0100
Subject: [GIT PULL] Reset controller changes for v4.12
Message-ID: <1488965177.2467.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

Please consider merging this tag, which adds new drivers for i.MX7 and
Arria10, removes module code from non-modular drivers, and fixes a build
warning in the uniphier driver and the nr_resets property usage of the
socfpga driver.

regards
Philipp

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.12

for you to fetch changes up to 2fd14a1f3d3a1835c401a21f2d813030a97eab7d:

  reset: Add Altera Arria10 SR Reset Controller (2017-03-08 09:36:45 +0100)

----------------------------------------------------------------
Reset controller changes for v4.12

- make reset drivers with bool Kconfig options explicitly non-modular
- fix uniphier non-static symbol warnings
- fix socfpga nr_resets property
- new drivers for the Arria10 and i.MX7 system reset controllers

----------------------------------------------------------------
Andrey Smirnov (1):
      reset: Add i.MX7 SRC reset driver

Paul Gortmaker (4):
      reset: meson: make it explicitly non-modular
      reset: oxnas: make it explicitly non-modular
      reset: ath79: make it explicitly non-modular
      reset: pistachio: make it explicitly non-modular

Rojhalat Ibrahim (1):
      reset-socfpga: Fix nr_resets property

Thor Thayer (3):
      dt-bindings: mfd: Add Altera Arria10 SR Reset Controller bindings
      dt-bindings: reset: a10sr: Add Arria10 SR Reset Controller offsets
      reset: Add Altera Arria10 SR Reset Controller

Wei Yongjun (1):
      reset: uniphier: fix non static symbol warnings

 .../devicetree/bindings/mfd/altera-a10sr.txt       |  11 ++
 .../devicetree/bindings/reset/fsl,imx7-src.txt     |  47 ++++++
 MAINTAINERS                                        |   2 +
 drivers/reset/Kconfig                              |  14 ++
 drivers/reset/Makefile                             |   3 +
 drivers/reset/reset-a10sr.c                        | 138 ++++++++++++++++++
 drivers/reset/reset-ath79.c                        |  27 ++--
 drivers/reset/reset-imx7.c                         | 158 +++++++++++++++++++++
 drivers/reset/reset-meson.c                        |  12 +-
 drivers/reset/reset-oxnas.c                        |   6 +-
 drivers/reset/reset-pistachio.c                    |   9 +-
 drivers/reset/reset-socfpga.c                      |  13 +-
 drivers/reset/reset-uniphier.c                     |  20 +--
 include/dt-bindings/reset/altr,rst-mgr-a10sr.h     |  33 +++++
 include/dt-bindings/reset/imx7-reset.h             |  62 ++++++++
 15 files changed, 501 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
 create mode 100644 drivers/reset/reset-a10sr.c
 create mode 100644 drivers/reset/reset-imx7.c
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-a10sr.h
 create mode 100644 include/dt-bindings/reset/imx7-reset.h
