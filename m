From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Apr 2016 18:13:30 +0200
Subject: [GIT PULL v2 4/4]: ARM: tegra: Enable the XUSB controller
In-Reply-To: <1461945149-23686-5-git-send-email-thierry.reding@gmail.com>
References: <1461945149-23686-5-git-send-email-thierry.reding@gmail.com>
Message-ID: <1461946410-24940-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-xusb-no-defconfig

for you to fetch changes up to 1333ce4defc5829d920472005c105eb0e0a1825a:

  ARM: tegra: Enable XUSB on Nyan (2016-04-29 16:49:56 +0200)

As discussed with Arnd on IRC, this is the same pull request but leaves
out the top two patches which modify the Tegra and multi-v7 default
configurations.

Thierry

----------------------------------------------------------------
ARM: tegra: Enable the XUSB controller

These changes add support for the XUSB controller on Tegra124. It is an
XHCI compatible controller that replaces the existing EHCI controllers.
Support is enabled on Venice2, Jetson TK1 and Nyan-based Chromebooks.

----------------------------------------------------------------
Andrew Bresticker (1):
      clk: tegra: Add interface to enable hardware control of SATA/XUSB PLLs

Thierry Reding (22):
      Merge branch 'for-4.7/clk' into for-4.7/phy
      phy: core: Allow children node to be overridden
      dt-bindings: phy: Add NVIDIA Tegra XUSB pad controller binding
      dt-bindings: phy: tegra-xusb-padctl: Add Tegra210 support
      phy: Add Tegra XUSB pad controller support
      phy: tegra: Add Tegra210 support
      Merge branch 'for-4.7/phy' into for-4.7/pci
      dt-bindings: pci: tegra: Update for per-lane PHYs
      PCI: tegra: Support per-lane PHYs
      Merge branch 'for-4.7/phy' into for-4.7/xhci
      dt-bindings: usb: Add NVIDIA Tegra XUSB controller binding
      dt-bindings: usb: xhci-tegra: Add Tegra210 XUSB controller support
      usb: xhci: Add NVIDIA Tegra XUSB controller driver
      usb: xhci: tegra: Add Tegra210 support
      Merge branch 'for-4.7/phy' into for-4.7/xusb
      Merge branch 'for-4.7/pci' into for-4.7/xusb
      Merge branch 'for-4.7/xhci' into for-4.7/xusb
      ARM: tegra: Move Tegra124 to the new XUSB pad controller binding
      ARM: tegra: Add Tegra124 XUSB controller
      ARM: tegra: Enable XUSB on Venice2
      ARM: tegra: Enable XUSB on Jetson TK1
      ARM: tegra: Enable XUSB on Nyan

 .../bindings/pci/nvidia,tegra20-pcie.txt           |  224 ++-
 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |  733 +++++++
 .../pinctrl/nvidia,tegra124-xusb-padctl.txt        |    6 +
 .../bindings/usb/nvidia,tegra124-xusb.txt          |  120 ++
 Documentation/phy.txt                              |   16 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  116 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi               |  122 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |  101 +-
 arch/arm/boot/dts/tegra124.dtsi                    |  167 +-
 drivers/clk/tegra/clk-tegra210.c                   |   58 +
 drivers/pci/host/pci-tegra.c                       |  244 ++-
 drivers/phy/Kconfig                                |    2 +
 drivers/phy/Makefile                               |    2 +
 drivers/phy/phy-core.c                             |   50 +-
 drivers/phy/tegra/Kconfig                          |    8 +
 drivers/phy/tegra/Makefile                         |    6 +
 drivers/phy/tegra/xusb-tegra124.c                  | 1752 +++++++++++++++++
 drivers/phy/tegra/xusb-tegra210.c                  | 2045 ++++++++++++++++++++
 drivers/phy/tegra/xusb.c                           | 1021 ++++++++++
 drivers/phy/tegra/xusb.h                           |  421 ++++
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |   20 +-
 drivers/usb/host/Kconfig                           |    9 +
 drivers/usb/host/Makefile                          |    1 +
 drivers/usb/host/xhci-tegra.c                      | 1331 +++++++++++++
 include/linux/clk/tegra.h                          |    5 +
 include/linux/phy/phy.h                            |   31 +-
 include/linux/phy/tegra/xusb.h                     |   30 +
 include/soc/tegra/fuse.h                           |    1 +
 28 files changed, 8536 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
 create mode 100644 drivers/phy/tegra/Kconfig
 create mode 100644 drivers/phy/tegra/Makefile
 create mode 100644 drivers/phy/tegra/xusb-tegra124.c
 create mode 100644 drivers/phy/tegra/xusb-tegra210.c
 create mode 100644 drivers/phy/tegra/xusb.c
 create mode 100644 drivers/phy/tegra/xusb.h
 create mode 100644 drivers/usb/host/xhci-tegra.c
 create mode 100644 include/linux/phy/tegra/xusb.h
