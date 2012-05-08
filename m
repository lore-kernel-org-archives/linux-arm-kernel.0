From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 May 2012 12:26:34 -0600
Subject: [GIT PULL] ARM: tegra: usb-ulpi branch
Message-ID: <4FA9655A.9020105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch is based on my previous gpio-pinmux pull request.

The following changes since commit aef7704c6cc36db9618603b22194def441d30432:
  Stephen Warren (1):
        pinctrl: tegra: error reporting cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
for-3.5/usb-ulpi

Allen Martin (1):
      ARM: tegra: Add pllc clock init table

Stephen Warren (6):
      ARM: tegra: reparent sclk to pll_c_out1
      ARM: tegra: fix pclk rate
      ARM: tegra: change pll_p_out4's rate to 24MHz
      ARM: tegra: don't hard-code USB ULPI PHY reset_gpio
      ARM: tegra: add USB ULPI PHY reset GPIO to device tree
      ARM: dt: tegra: pinmux changes for USB ULPI

 .../devicetree/bindings/usb/tegra-usb.txt          |    3 ++
 arch/arm/boot/dts/tegra-harmony.dts                |   24
+++++++++++--------
 arch/arm/boot/dts/tegra-paz00.dts                  |   18 +++++++-------
 arch/arm/boot/dts/tegra-seaboard.dts               |    4 +++
 arch/arm/boot/dts/tegra-trimslice.dts              |   22 ++++++++++-------
 arch/arm/boot/dts/tegra-ventana.dts                |    4 +++
 arch/arm/mach-tegra/board-paz00.c                  |    3 +-
 arch/arm/mach-tegra/board-trimslice.c              |    2 +
 arch/arm/mach-tegra/common.c                       |   10 +++++---
 arch/arm/mach-tegra/devices.c                      |    5 +--
 arch/arm/mach-tegra/devices.h                      |    4 +++
 arch/arm/mach-tegra/include/mach/usb_phy.h         |    4 +-
 arch/arm/mach-tegra/tegra2_clocks.c                |    4 +++
 arch/arm/mach-tegra/usb_phy.c                      |   15 ++++++++++-
 drivers/usb/host/ehci-tegra.c                      |    5 ++-
 15 files changed, 85 insertions(+), 42 deletions(-)
