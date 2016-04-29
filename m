From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Apr 2016 17:52:28 +0200
Subject: [GIT PULL 3/4]: usb: host: xhci-tegra: Changes for v4.7-rc1
In-Reply-To: <1461945149-23686-1-git-send-email-thierry.reding@gmail.com>
References: <1461945149-23686-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1461945149-23686-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 87d66f280672800c9c2ad1ce3b7a993ce1e04769:

  phy: tegra: Add Tegra210 support (2016-04-29 16:44:48 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-xhci

for you to fetch changes up to ab065e969640d9afd3967266eb3193fb3ac298bd:

  usb: xhci: tegra: Add Tegra210 support (2016-04-29 16:48:59 +0200)

This depends on pull request 1/4 containing the PHY changes.

Thierry

----------------------------------------------------------------
usb: host: xhci-tegra: Changes for v4.7-rc1

This set of patches introduces a driver for the XUSB controller found on
NVIDIA Tegra SoCs. When loaded with a firmware (available via the linux-
firmware repository), it provides an XHCI-compatible interface.

----------------------------------------------------------------
Thierry Reding (5):
      Merge branch 'for-4.7/phy' into for-4.7/xhci
      dt-bindings: usb: Add NVIDIA Tegra XUSB controller binding
      dt-bindings: usb: xhci-tegra: Add Tegra210 XUSB controller support
      usb: xhci: Add NVIDIA Tegra XUSB controller driver
      usb: xhci: tegra: Add Tegra210 support

 .../bindings/usb/nvidia,tegra124-xusb.txt          |  120 ++
 drivers/usb/host/Kconfig                           |    9 +
 drivers/usb/host/Makefile                          |    1 +
 drivers/usb/host/xhci-tegra.c                      | 1331 ++++++++++++++++++++
 4 files changed, 1461 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
 create mode 100644 drivers/usb/host/xhci-tegra.c
