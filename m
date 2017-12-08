From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 08 Dec 2017 11:34:04 -0800
Subject: [GIT PULL] Amlogic fixes for v4.15-rc (redo v2)
Message-ID: <7ha7ytm2tv.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here's a re-spin of the Amlogic fixes for v4.15-rc with the DT changes
for new hardware dropped.  Will (re)send those for v4.16.

Also, since the last round, I've collected one more fix for a UART clock
naming bug.

Kevin

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes-1

for you to fetch changes up to 39005e562a88c61fa77acef1d2c0cb81ee6b0423:

  ARM64: dts: meson-gx: fix UART pclk clock name (2017-12-08 10:39:11 -0800)

----------------------------------------------------------------
Amlogic fixes for v4.15-rc
- GPIO interrupt fixes
- socinfo fix for GX series
- fix typo

----------------------------------------------------------------
Arnaud Patard (1):
      meson-gx-socinfo: Fix package id parsing

Colin Ian King (1):
      ARM: meson: fix spelling mistake: "Couln't" -> "Couldn't"

Martin Blumenstingl (2):
      ARM: dts: meson: correct the sort order for the the gpio_intc node
      ARM: dts: meson: fix the memory region of the GPIO interrupt controller

Neil Armstrong (1):
      ARM64: dts: meson-gx: fix UART pclk clock name

 arch/arm/boot/dts/meson.dtsi                | 18 +++++++++---------
 arch/arm/mach-meson/platsmp.c               |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  6 +++---
 drivers/soc/amlogic/meson-gx-socinfo.c      |  4 ++--
 5 files changed, 17 insertions(+), 17 deletions(-)
