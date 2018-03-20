From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 19 Mar 2018 17:08:54 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.17
Message-ID: <7hh8pbr4kp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to 0793d5376b9986283e8bf9c777eb6ffda5c1b925:

  ARM: dts: meson8b-odroidc1: add microSD support (2018-03-19 16:46:46 -0700)

----------------------------------------------------------------
Amlogic 32-bit DT updates for v4.17
- odroid-c1: add microSD, ethernet, USB reset
- add reset controller
- fix requesting GPIOs greater than GPIOZ_3

----------------------------------------------------------------
Emiliano Ingrassia (2):
      ARM: dts: meson8b: extend ethernet controller description
      ARM: dts: meson8b-odroidc1: ethernet support

Linus L?ssing (1):
      ARM: dts: meson8b-odroidc1: add microSD support

Martin Blumenstingl (5):
      ARM: dts: meson8b: grow the reset controller memory zone
      ARM: dts: meson8: add the reset controller
      ARM: dts: meson8: add the USB reset line
      ARM: dts: meson8b: add the I2C clocks
      pinctrl: meson: meson8b: fix requesting GPIOs greater than GPIOZ_3

 arch/arm/boot/dts/meson8.dtsi           |   9 +++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts  |  88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi          |  57 +++++++++++++++++++++++++++++++++++++++++---
 drivers/pinctrl/meson/pinctrl-meson8b.c |  20 +++++++++-------
 include/dt-bindings/gpio/meson8b-gpio.h | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 5 files changed, 271 insertions(+), 24 deletions(-)
