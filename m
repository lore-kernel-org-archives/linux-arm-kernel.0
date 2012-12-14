From: vbyravarasu@nvidia.com (Venu Byravarasu)
Date: Fri, 14 Dec 2012 12:29:06 +0530
Subject: [PATCH 0/2] usb: tegra: modifying port reset based on instance number
Message-ID: <1355468348-8821-1-git-send-email-vbyravarasu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra USB host driver is using port instance number,
to handle some of the hardware issues on SOC e.g. reset PORT0
twice etc. As instance number based handling looks ugly,
added a new property to USB DT node for this purpose.
Modified host driver to make use of the information passed
through DT to reset the port second time.


Venu Byravarasu (2):
  arm: tegra: Add new DT property to USB node.
  usb: host: tegra: Resetting PORT0 based on information received via
    DT.

 .../bindings/usb/nvidia,tegra20-ehci.txt           |    2 ++
 arch/arm/boot/dts/tegra20.dtsi                     |    1 +
 drivers/usb/host/ehci-tegra.c                      |    6 +++++-
 3 files changed, 8 insertions(+), 1 deletions(-)
