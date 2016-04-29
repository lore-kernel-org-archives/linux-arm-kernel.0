From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Apr 2016 17:52:26 +0200
Subject: [GIT PULL 1/4]: phy: tegra: Changes for v4.7-rc1
In-Reply-To: <1461945149-23686-1-git-send-email-thierry.reding@gmail.com>
References: <1461945149-23686-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1461945149-23686-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3358d2d9f47af86bdd71edb24b361f72a54ec04e:

  clk: tegra: Add interface to enable hardware control of SATA/XUSB PLLs (2016-04-28 12:41:44 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-phy

for you to fetch changes up to 87d66f280672800c9c2ad1ce3b7a993ce1e04769:

  phy: tegra: Add Tegra210 support (2016-04-29 16:44:48 +0200)

This depends on the first patch of a separate branch that will be
merged through the clk tree.

Thierry

----------------------------------------------------------------
phy: tegra: Changes for v4.7-rc1

This set of patches adds support for the Tegra XUSB pad controller. The
controller provides a set of pads (lanes) that are used for I/O by other
IP blocks within Tegra SoCs (PCIe, SATA and XUSB).

----------------------------------------------------------------
Thierry Reding (6):
      Merge branch 'for-4.7/clk' into for-4.7/phy
      phy: core: Allow children node to be overridden
      dt-bindings: phy: Add NVIDIA Tegra XUSB pad controller binding
      dt-bindings: phy: tegra-xusb-padctl: Add Tegra210 support
      phy: Add Tegra XUSB pad controller support
      phy: tegra: Add Tegra210 support

 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |  733 +++++++
 .../pinctrl/nvidia,tegra124-xusb-padctl.txt        |    6 +
 Documentation/phy.txt                              |   16 +-
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
 include/linux/phy/phy.h                            |   31 +-
 include/linux/phy/tegra/xusb.h                     |   30 +
 include/soc/tegra/fuse.h                           |    1 +
 16 files changed, 6110 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
 create mode 100644 drivers/phy/tegra/Kconfig
 create mode 100644 drivers/phy/tegra/Makefile
 create mode 100644 drivers/phy/tegra/xusb-tegra124.c
 create mode 100644 drivers/phy/tegra/xusb-tegra210.c
 create mode 100644 drivers/phy/tegra/xusb.c
 create mode 100644 drivers/phy/tegra/xusb.h
 create mode 100644 include/linux/phy/tegra/xusb.h
