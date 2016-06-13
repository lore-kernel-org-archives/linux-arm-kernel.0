From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 13 Jun 2016 16:07:37 +0200
Subject: [GIT PULL] Reset controller changes for v4.8, part 2
Message-ID: <1465826857.3553.50.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

Please consider merging this tag with a new driver for the Amlogic Meson
reset controller. It should be fine for Kevin to also merge this into
his for-next branch to resolve the dependency of meson dtsi files on the
new dt-bindings headers.

regards
Philipp

The following changes since commit 168d7c4e8bb25c076ed8be67fcca84f5dcd0b2c6:

  reset: Return -ENOTSUPP when not configured (2016-06-01 08:21:08 +0200)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.8-2

for you to fetch changes up to 79795e20a184ebabf4ae743d1506cc39783caa46:

  dt-bindings: reset: Add bindings for the Meson SoC Reset Controller (2016-06-01 08:21:12 +0200)

----------------------------------------------------------------
Reset controller changes for v4.8, part 2

- add Amlogic Meson SoC Reset Controller driver

----------------------------------------------------------------
Neil Armstrong (2):
      reset: Add support for the Amlogic Meson SoC Reset Controller
      dt-bindings: reset: Add bindings for the Meson SoC Reset Controller

 .../bindings/reset/amlogic,meson-reset.txt         |  18 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-meson.c                        | 136 +++++++++++++
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   | 210 +++++++++++++++++++++
 include/dt-bindings/reset/amlogic,meson8b-reset.h  | 175 +++++++++++++++++
 5 files changed, 540 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
 create mode 100644 drivers/reset/reset-meson.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson8b-reset.h
