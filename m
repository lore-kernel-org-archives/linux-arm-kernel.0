From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 May 2016 22:07:57 +0200
Subject: [GIT PULL] ARM: SoC: late DT updates for v4.7
In-Reply-To: <6880123.QJWf7jilUK@wuerfel>
References: <6880123.QJWf7jilUK@wuerfel>
Message-ID: <5530966.8xa1nqVXh4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ab065e969640d9afd3967266eb3193fb3ac298bd:

  usb: xhci: tegra: Add Tegra210 support (2016-04-29 16:48:59 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to 88f1847639d68d732f83adb7aae94e0d989f7e28:

  Merge tag 'samsung-dt-devfreq-4.7' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into next/late (2016-05-10 16:17:55 +0200)

----------------------------------------------------------------
This is a collection of a few late fixes and other misc. stuff that
had dependencies on things being merged from other trees.

The Renesas R-Car power domain handling, and the Nvidia Tegra USB
support both hand notable changes that required changing the DT binding
in a way that only provides compatibility with old DT blobs on new
kernels but not vice versa. As a consequence, the DT changes
are based on top of the driver changes and are now in this branch.

For NXP i.MX and Samsung Exynos, the changes in here depend on
other changes that got merged through the clk maintainer tree.

----------------------------------------------------------------
Arnd Bergmann (6):
      Merge tag 'renesas-dt-pm-domain-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/late
      Merge tag 'renesas-arm64-dt-pm-domain-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/late
      Merge branches 'tegra/pci' and 'tegra/usb' into next/late
      Merge tag 'tegra-for-4.7-xusb-no-defconfig' of git://git.kernel.org/.../tegra/linux into next/late
      Merge tag 'imx-dt-clkdep-4.7' of git://git.kernel.org/.../shawnguo/linux into next/late
      Merge tag 'samsung-dt-devfreq-4.7' of git://git.kernel.org/.../krzk/linux into next/late

Chanwoo Choi (15):
      dt-bindings: clock: Add the clock id for ACLK clock of Exynos542x SoC
      clk: samsung: exynos542x: Add the clock id for ACLK
      ARM: dts: exynos: Add DMC bus node for Exynos3250
      ARM: dts: exynos: Add DMC bus frequency for exynos3250-rinato/monk
      ARM: dts: exynos: Add bus nodes using VDD_INT for Exynos3250
      ARM: dts: exynos: Add bus nodes using VDD_MIF for Exynos4x12
      ARM: dts: exynos: Add bus nodes using VDD_INT for Exynos4x12
      ARM: dts: exynos: Add bus nodes using VDD_MIF for Exynos4210
      ARM: dts: exynos: Add exynos4412-ppmu-common dtsi to delete duplicate PPMU nodes
      ARM: dts: exynos: Add support of bus frequency using VDD_INT for exynos3250-rinato
      ARM: dts: exynos: Expand the voltage range of buck1/3 regulator for exynos4412-odroidu3
      ARM: dts: exynos: Add support of bus frequency for exynos4412-trats/odroidu3
      ARM: dts: exynos: Add NoC Probe dt node for Exynos542x SoC
      ARM: dts: exynos: Add bus nodes using VDD_INT for Exynos542x SoC
      ARM: dts: exynos: Add support of Bus frequency using VDD_INT for exynos5422-odroidxu3

Fabio Estevam (1):
      clk: imx6sx: Register SAI clocks as shared clocks

Gary Bisson (4):
      clk: imx: add ckil clock for i.MX7
      ARM: dts: imx7d: add lcdif support
      ARM: dts: imx7d: add flexcan support
      ARM: dts: imx: add Boundary Devices Nitrogen7 board

Geert Uytterhoeven (12):
      arm64: dts: r8a7795: Add SYSC PM Domains
      arm64: dts: r8a7795: Use SYSC "always-on" PM Domain
      ARM: dts: r8a7779: Add SYSC PM Domains
      ARM: dts: r8a7790: Add SYSC PM Domains
      ARM: dts: r8a7791: Add SYSC PM Domains
      ARM: dts: r8a7793: Add SYSC PM Domains
      ARM: dts: r8a7794: Add SYSC PM Domains
      ARM: dts: r8a7779: Use SYSC "always-on" PM Domain
      ARM: dts: r8a7790: Use SYSC "always-on" PM Domain
      ARM: dts: r8a7791: Use SYSC "always-on" PM Domain
      ARM: dts: r8a7793: Use SYSC "always-on" PM Domain
      ARM: dts: r8a7794: Use SYSC "always-on" PM Domain

Krzysztof Kozlowski (1):
      Merge tag 'clk-v4.7-exynos542x' of git://linuxtv.org/snawrocki/samsung into for-v4.7-late/dts-exynos-devfreq

Shawn Guo (2):
      clk: imx: vf610: fix whitespace in vf610-clock.h
      Merge tag 'imx-clk-4.7' into imx/dt-clkdep

Simon Horman (2):
      Merge tag 'renesas-rcar-sysc2-for-v4.7' into dt-pm-domain-for-v4.7
      Merge tag 'renesas-rcar-sysc2-for-v4.7' into arm64-dt-pm-domain-for-v4.7

Stefan Agner (8):
      clk: imx: clk-gate2: allow custom gate configuration
      clk: imx: vf610: leave DDR clock on
      clk: imx: vf610: add WKPU unit
      clk: imx: vf610: add suspend/resume support
      clk: imx: vf610: fix DCU clock tree
      clk: imx: vf610: add TCON ipg clock
      ARM: dts: vf610: add display nodes
      ARM: dts: vf610-colibri: enable display controller

Thierry Reding (8):
      Merge branch 'for-4.7/phy' into for-4.7/xusb
      Merge branch 'for-4.7/pci' into for-4.7/xusb
      Merge branch 'for-4.7/xhci' into for-4.7/xusb
      ARM: tegra: Move Tegra124 to the new XUSB pad controller binding
      ARM: tegra: Add Tegra124 XUSB controller
      ARM: tegra: Enable XUSB on Venice2
      ARM: tegra: Enable XUSB on Jetson TK1
      ARM: tegra: Enable XUSB on Nyan

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos3250-monk.dts              |  47 +--
 arch/arm/boot/dts/exynos3250-rinato.dts            |  88 +++---
 arch/arm/boot/dts/exynos3250.dtsi                  | 181 +++++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  | 159 ++++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  56 +++-
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |  50 ++++
 arch/arm/boot/dts/exynos4412-trats2.dts            |  88 +++---
 arch/arm/boot/dts/exynos4x12.dtsi                  | 174 +++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                  | 407 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  99 ++++++
 arch/arm/boot/dts/imx7d-nitrogen7.dts              | 745 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d.dtsi                       |  31 ++
 arch/arm/boot/dts/r8a7779.dtsi                     |  54 ++--
 arch/arm/boot/dts/r8a7790.dtsi                     | 155 +++++-----
 arch/arm/boot/dts/r8a7791.dtsi                     | 156 +++++-----
 arch/arm/boot/dts/r8a7793.dtsi                     | 111 +++----
 arch/arm/boot/dts/r8a7794.dtsi                     | 116 ++++----
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          | 116 +++++++-
 arch/arm/boot/dts/tegra124-nyan.dtsi               | 122 ++++++--
 arch/arm/boot/dts/tegra124-venice2.dts             | 101 ++++++-
 arch/arm/boot/dts/tegra124.dtsi                    | 167 ++++++++++-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  16 +
 arch/arm/boot/dts/vf-colibri.dtsi                  |  33 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |  19 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 123 ++++----
 26 files changed, 2918 insertions(+), 497 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-nitrogen7.dts
