From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 Mar 2017 16:56:34 +0100
Subject: [GIT PULL] ARM: late soc updates for 4.11
Message-ID: <7773127.YrcxT41Th4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b2e3c4319d40c9055c3c587cdb82ba69b50e919d:

  Merge tag 'armsoc-drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2017-02-23 15:57:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to ca2dea434d10e3a676482fdf6df17d20cdb3e907:

  Merge tag 'juno-fixes-4.11' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into next/late (2017-03-02 23:08:31 +0100)

----------------------------------------------------------------
ARM: SoC: late DT updates for v4.11

These updates have been kept in a separate branch mostly because
they rely on updates to the respective clk drivers to keep the
shared header files in sync.

This includes two branches for arm64 dt updates, both following up
on earlier changes for the same platforms that are already merged:

Samsung:
  - add USB3 support in Exynos7
  - minor PM related updates

Amlogic:
  - new machines: WeTek Set-top-boxes
  - various devices added to DT

There are also a couple of bugfixes that trickled in since the
start of the merge window:

- The moxart_defconfig was not building the intended platform
- CPU-hotplug was broken on ux500
- Coresight was broken on Juno (never worked)

----------------------------------------------------------------
Andreas F?rber (1):
      ARM64: dts: meson-gxbb-vega-s95: Add LED

Arnd Bergmann (4):
      Merge tag 'samsung-dt64-4.11-3' of git://git.kernel.org/.../krzk/linux into next/late
      Merge tag 'amlogic-dt64-2' of git://git.kernel.org/.../khilman/linux-amlogic into next/late
      Merge branch 'next/late' with mainline
      Merge tag 'juno-fixes-4.11' of git://git.kernel.org/.../sudeep.holla/linux into next/late

Kevin Hilman (1):
      ARM64: dts: meson-gxl: rename Nexbox A95x for consistency

Krzysztof Kozlowski (2):
      Merge tag 'clk-v4.11-samsung-dphy' of git://linuxtv.org/snawrocki/samsung into next/dt64
      Merge tag 'samsung-pinctrl-4.11' into next/dt64

Linus Walleij (2):
      ARM: ux500: resume the second core properly
      ARM: deconfig: fix the moxart defconfig

Marek Szyprowski (1):
      arm64: dts: exynos: Add initial configuration for DISP clocks for TM2/TM2e

Martin Blumenstingl (8):
      ARM64: dts: meson-gx: move the SCPI and SRAM nodes to meson-gx
      ARM64: dts: meson-gxm: add SCPI configuration for GXM
      ARM64: dts: meson-gx: add the missing uart_AO_B
      ARM64: dts: meson-gx: add the serial CTS and RTS pin groups
      clk: gxbb: add the SAR ADC clocks and expose them
      ARM64: dts: meson-gx: add the missing pwm_AO_ab node
      ARM64: dts: meson-gxl: add the pwm_ao_b pin
      ARM64: dts: meson: meson-gx: add the SAR ADC

Mike Leach (1):
      arm64: dts: juno: update definition for programmable replicator

Neil Armstrong (7):
      clk: meson-gxbb: Export HDMI clocks
      ARM64: dts: meson-gx: Add HDMI HPD/DDC pinctrl nodes
      ARM64: dts: meson-gxm: Rename q200 and q201 DT files for consistency
      dt-bindings: vendor-prefix: Add wetek vendor prefix
      ARM64: dts: meson-gxbb: Add support for WeTek Hub and Play
      dt-bindings: amlogic: Add WeTek boards
      ARM64: dts: meson-gxbb-p200: add ADC laddered keys

Pankaj Dubey (2):
      pinctrl: dt-bindings: samsung: Add Exynos7 specific pinctrl macro definitions
      arm64: dts: exynos: Use macros for pinctrl configuration on Exynos7

Vivek Gautam (2):
      arm64: dts: exynos: Add USB 3.0 controller node for Exynos7
      arm64: dts: exynos: Add regulators for Vbus and Vbus-Boost

jbrunet (1):
      clk: gxbb: fix CLKID_ETH defined twice

 Documentation/devicetree/bindings/arm/amlogic.txt  |   2 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/configs/moxart_defconfig                  |  12 +-
 arch/arm/mach-ux500/Makefile                       |   3 -
 arch/arm/mach-ux500/cpu-db8500.c                   |   2 -
 arch/arm/mach-ux500/hotplug.c                      |  37 ---
 arch/arm/mach-ux500/platsmp.c                      |   9 +-
 arch/arm/mach-ux500/setup.h                        |  16 --
 arch/arm64/boot/dts/amlogic/Makefile               |   8 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |  68 +++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |  50 ++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  11 +
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      |  66 +++++
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    |  94 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 128 +++++----
 ...ox-a95x.dts => meson-gxl-s905x-nexbox-a95x.dts} |   0
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  78 ++++++
 ...{meson-gxm-s912-q200.dts => meson-gxm-q200.dts} |   0
 ...{meson-gxm-s912-q201.dts => meson-gxm-q201.dts} |   0
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |  14 +
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  13 +-
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |  12 -
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  34 +++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |  34 +++
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |  49 +++-
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    | 302 +++++++++++----------
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  34 +++
 drivers/clk/meson/gxbb.c                           |  48 ++++
 drivers/clk/meson/gxbb.h                           |  15 +-
 drivers/clk/samsung/clk-exynos5433.c               |   8 +-
 include/dt-bindings/clock/exynos5433.h             |   5 +-
 include/dt-bindings/clock/gxbb-clkc.h              |   6 +
 include/dt-bindings/pinctrl/samsung.h              |   8 +
 33 files changed, 862 insertions(+), 305 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/hotplug.c
 delete mode 100644 arch/arm/mach-ux500/setup.h
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
 rename arch/arm64/boot/dts/amlogic/{meson-gxl-nexbox-a95x.dts => meson-gxl-s905x-nexbox-a95x.dts} (100%)
 rename arch/arm64/boot/dts/amlogic/{meson-gxm-s912-q200.dts => meson-gxm-q200.dts} (100%)
 rename arch/arm64/boot/dts/amlogic/{meson-gxm-s912-q201.dts => meson-gxm-q201.dts} (100%)
