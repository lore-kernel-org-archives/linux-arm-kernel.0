From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 23:29:16 +0000
Subject: [GIT PULL 2/4] ARM: mvebu: drivers for v3.9
In-Reply-To: <pull-1358033364-983365>
Message-ID: <mailman.27.1358033396.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/drivers_for_v3.9

for you to fetch changes up to a6ae83d745063fee77648afc95de58d7a82d4df5:

  mmc: mvsdio: add pinctrl integration (2013-01-10 02:46:59 +0000)

----------------------------------------------------------------
mvebu drivers for v3.9
 - mvsdio
   - use slot-gpio for card detect and write protect
   - add DT binding
   - add pinctrl integration
 - use rtc-mv in mvebu armv7 SoCs
 - add pci-e hotplug for kirkwood

----------------------------------------------------------------
Gregory CLEMENT (1):
      rtc: Add support of rtc-mv for MVEBU SoCs

Jason Gunthorpe (1):
      ARM: Kirkwood: Support basic hotplug for PCI-E

Thomas Petazzoni (4):
      mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
      mmc: mvsdio: use slot-gpio for card detect gpio
      mmc: mvsdio: implement a Device Tree binding
      mmc: mvsdio: add pinctrl integration

 .../devicetree/bindings/mmc/orion-sdio.txt         |  17 +++
 arch/arm/mach-kirkwood/pcie.c                      |  10 +-
 drivers/mmc/host/mvsdio.c                          | 136 +++++++++------------
 drivers/rtc/Kconfig                                |   2 +-
 4 files changed, 82 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
