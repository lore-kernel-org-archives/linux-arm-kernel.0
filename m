From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Aug 2013 11:20:27 -0600
Subject: [GIT PULL 3/4] ARM: tegra: device tree changes for 3.12
In-Reply-To: <1376673628-5867-1-git-send-email-swarren@wwwdotorg.org>
References: <1376673628-5867-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1376673628-5867-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains all *.dts (device tree) changes for Tegra.
New features enabled are:

* PMICs on Dalmore
* CPU power-gating on Dalmore
* HDMI output on Beaver
* LP1 system suspend mode on almost all boards
* PCIe support on numerous Tegra20/30 boards
* USB support on Tegra30/114 boards
* Audio capture on Beaver and Dalmore
* Temperature sensor on Cardhu.

... along with a few DT cleanups.

----------------------------------------------------------------

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.12-dt

for you to fetch changes up to 8af3bbec752902c0480c84613d7f10e22f485977:

  ARM: tegra: add Mic Jack to Dalmore device tree

----------------------------------------------------------------

Jay Agarwal (2):
      ARM: tegra: Enable PCIe controller on Cardhu
      ARM: dts: tegra: Increase prefetchable PCI memory space

Joseph Lo (3):
      ARM: tegra: dalmore: add PM configurations for PMC
      ARM: tegra: dalmore: fix the irq trigger type of Palmas MFD device
      ARM: tegra: enable LP1 suspend mode

Laxman Dewangan (3):
      ARM: tegra: enable gpio-keys on Dalmore
      ARM: tegra: enable palmas device for dalmore
      ARM: tegra: define valid function names in DT document

Mikko Perttunen (1):
      ARM: tegra: add USB DT entries for Tegra114, Dalmore

Stephen Warren (6):
      ARM: tegra: fix DT node ordering in Tegra30 Cardhu
      ARM: tegra: remove tegra114-pluto.dts
      ARM: tegra: use TEGRA_GPIO() in a couple more places
      ARM: tegra: Fix Beaver's PCIe lane configuration
      ARM: tegra: add Mic Jack to Beaver device tree
      ARM: tegra: add Mic Jack to Dalmore device tree

Thierry Reding (8):
      ARM: tegra: beaver: Enable HDMI output
      ARM: tegra: Add Tegra20 PCIe support to DT
      ARM: tegra: tamonten: Add PCIe support
      ARM: tegra: tec: Add PCIe support
      ARM: tegra: harmony: Initialize PCIe from DT
      ARM: tegra: trimslice: Initialize PCIe from DT
      ARM: tegra: Add Tegra30 PCIe support
      ARM: tegra: Enable PCIe controller on Beaver

Tuomas Tynkkynen (1):
      ARM: tegra: add USB DT entries for Tegra30

Wei Ni (1):
      ARM: tegra: add DT entry for nct1008 to Cardhu

 .../bindings/pinctrl/nvidia,tegra114-pinmux.txt |  11 +
 .../bindings/pinctrl/nvidia,tegra20-pinmux.txt  |  11 +
 .../bindings/pinctrl/nvidia,tegra30-pinmux.txt  |  12 +
 arch/arm/boot/dts/Makefile                      |   3 +-
 arch/arm/boot/dts/tegra114-dalmore.dts          | 235 ++++++++++++++++++-
 arch/arm/boot/dts/tegra114-pluto.dts            |  33 ---
 arch/arm/boot/dts/tegra114.dtsi                 |  62 +++++
 arch/arm/boot/dts/tegra20-colibri-512.dtsi      |   2 +-
 arch/arm/boot/dts/tegra20-harmony.dts           |  22 +-
 arch/arm/boot/dts/tegra20-paz00.dts             |   2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts          |   4 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |  19 +-
 arch/arm/boot/dts/tegra20-tec.dts               |   8 +
 arch/arm/boot/dts/tegra20-trimslice.dts         |  32 ++-
 arch/arm/boot/dts/tegra20-ventana.dts           |   2 +-
 arch/arm/boot/dts/tegra20-whistler.dts          |   2 +-
 arch/arm/boot/dts/tegra20.dtsi                  |  55 +++++
 arch/arm/boot/dts/tegra30-beaver.dts            |  64 ++++-
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |  64 +++--
 arch/arm/boot/dts/tegra30.dtsi                  | 156 ++++++++++++
 20 files changed, 728 insertions(+), 71 deletions(-)
 delete mode 100644 arch/arm/boot/dts/tegra114-pluto.dts
