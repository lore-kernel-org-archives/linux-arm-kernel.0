From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 15 May 2018 15:29:46 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.18
Message-ID: <7hh8n8tuw5.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is mostly DT, but contains also contains the mach-meson change to
build the new DT, which might be more appropriate for the 'soc' branch,
but I left it here because it's just about enabling the new DT.  Let me
know if you prefer it split out.

Kevin


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to 35ee52bea66c74a7c33cebda8692d61b1ed7c6e9:

  ARM: dts: meson8m2: add support for the Tronsmart MXIII Plus (2018-05-10 17:03:28 -0700)

----------------------------------------------------------------
Amlogic 32-bit DT updates for v4.18
- add support for meson8m2 SoC
- new board: Tronsmart MXIII Plus using meson8m2 SoC
- odroid-c1: add IR

----------------------------------------------------------------
Martin Blumenstingl (7):
      ARM: dts: meson8: add the cortex-a9-pmu compatible PMU
      ARM: dts: meson8b: add the cortex-a5-pmu compatible PMU
      ARM: dts: meson8b: odroid-c1: sort nodes alphabetically
      ARM: dts: meson8b: odroid-c1: enable the IR receiver
      ARM: meson: add support for the Meson8m2 SoCs
      ARM: dts: meson: add support for the Meson8m2 SoC
      ARM: dts: meson8: add the uart_A pins

Oleg Ivanov (1):
      ARM: dts: meson8m2: add support for the Tronsmart MXIII Plus

 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/meson8.dtsi             |  33 +++++++++++--
 arch/arm/boot/dts/meson8b-odroidc1.dts    |  68 ++++++++++++++------------
 arch/arm/boot/dts/meson8b.dtsi            |  24 +++++++--
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8m2.dtsi           |  54 ++++++++++++++++++++
 arch/arm/mach-meson/Kconfig               |   2 +-
 arch/arm/mach-meson/meson.c               |   1 +
 8 files changed, 388 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/boot/dts/meson8m2-mxiii-plus.dts
 create mode 100644 arch/arm/boot/dts/meson8m2.dtsi
