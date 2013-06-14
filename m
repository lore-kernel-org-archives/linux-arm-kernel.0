From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Jun 2013 10:37:16 -0600
Subject: [GIT PULL 3/5] ARM: tegra: device tree updates
In-Reply-To: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
References: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1371227838-18764-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains all device tree updates for Tegra boards.

The changes are:

* Converted all DT files to use the C pre-processor, to support the use
  of named constants. This included use of defines for GPIO, IRQ, and
  clock constants.
* Enabling new features such as:
  - SPI on Dalmore.
  - Audio on Dalmore and Beaver.
  - gpio-leds on Beaver.
  - Power-supply/batter linkage on Dalmore.
* A minor fix to the RAM size node on Beaver.

It is based on previous pull request tegra-for-3.11-deps-for-usb
followed by a merge of tegra-for-3.11-deps-for-clk.

----------------------------------------------------------------

The following changes since commit 220cf5fb5c9eeef49930ff6fca2943286ec075a4:

  Merge branch 'for-3.11/deps-for-clk' into for-3.11/dt

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.11-dt

for you to fetch changes up to 23037bbd9661b53236ebe934c77952e8f73f1c7a:

  ARM: tegra: enable audio on Beaver

----------------------------------------------------------------

Eric Brower (1):
      ARM: tegra: Add gpio-leds to Tegra30 Beaver

Hiroshi Doyu (3):
      ARM: tegra20: convert device tree files to use CLK defines
      ARM: tegra30: convert device tree files to use CLK defines
      ARM: tegra114: convert device tree files to use CLK defines

Laxman Dewangan (1):
      ARM: tegra: enable spi4 on Dalmore

Rhyland Klein (2):
      ARM: tegra: Add charger subnode to tps65090 node
      ARM: tegra: add power-supplies link between battery and charger

Stephen Warren (8):
      ARM: tegra: fix memory size on Beaver
      ARM: tegra: use #include for all device trees
      ARM: tegra: create a DT header defining GPIO IDs
      ARM: tegra: convert device tree files to use GPIO defines
      ARM: tegra: convert device tree files to use IRQ defines
      ARM: tegra: add audio-related nodes to Tegra114 DT
      ARM: tegra: enable audio on Dalmore
      ARM: tegra: enable audio on Beaver

 arch/arm/boot/dts/tegra114-dalmore.dts     |  71 +++++-
 arch/arm/boot/dts/tegra114-pluto.dts       |   2 +-
 arch/arm/boot/dts/tegra114.dtsi            | 277 +++++++++++++++--------
 arch/arm/boot/dts/tegra20-colibri-512.dtsi |  27 ++-
 arch/arm/boot/dts/tegra20-harmony.dts      |  56 +++--
 arch/arm/boot/dts/tegra20-iris-512.dts     |   4 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts  |  12 +-
 arch/arm/boot/dts/tegra20-paz00.dts        |  37 +--
 arch/arm/boot/dts/tegra20-plutux.dts       |  12 +-
 arch/arm/boot/dts/tegra20-seaboard.dts     |  47 ++--
 arch/arm/boot/dts/tegra20-tamonten.dtsi    |  11 +-
 arch/arm/boot/dts/tegra20-tec.dts          |  13 +-
 arch/arm/boot/dts/tegra20-trimslice.dts    |  25 +-
 arch/arm/boot/dts/tegra20-ventana.dts      |  49 ++--
 arch/arm/boot/dts/tegra20-whistler.dts     |  19 +-
 arch/arm/boot/dts/tegra20.dtsi             | 258 +++++++++++----------
 arch/arm/boot/dts/tegra30-beaver.dts       |  68 ++++--
 arch/arm/boot/dts/tegra30-cardhu-a02.dts   |  16 +-
 arch/arm/boot/dts/tegra30-cardhu-a04.dts   |  18 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi      |  47 ++--
 arch/arm/boot/dts/tegra30.dtsi             | 288 +++++++++++++-----------
 include/dt-bindings/gpio/tegra-gpio.h      |  50 ++++
 22 files changed, 860 insertions(+), 547 deletions(-)
 create mode 100644 include/dt-bindings/gpio/tegra-gpio.h
