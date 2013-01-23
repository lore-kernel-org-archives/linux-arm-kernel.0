From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 02:48:05 +0000
Subject: [GIT PULL V2 2/4] ARM: mvebu: drivers for v3.9
In-Reply-To: <1358909281.35276e0.21555@triton>
Message-ID: <1358909285.ca5b742.21555@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4b53ab9cb853e446f628e561ce6fcc527df30a76:

  Merge branch 'mvebu/fixes' into mvebu/drivers (2013-01-23 01:42:14 +0000)

are available in the git repository at:


  git://git.infradead.org/users/jcooper/linux.git tags/drivers_for_v3.9

for you to fetch changes up to 43076a4c4e5fb92721bedc5d05b93468d6d76b2c:

  mmc: mvsdio: add pinctrl integration (2013-01-23 01:42:29 +0000)

----------------------------------------------------------------
mvebu drivers for v3.9
 - mvsdio
   - use slot-gpio for card detect and write protect
   - add DT binding
   - add pinctrl integration
 - use rtc-mv in mvebu armv7 SoCs
 - add pci-e hotplug for kirkwood

depends on:
 - mvebu/fixes

----------------------------------------------------------------
Thomas Petazzoni (4):
      mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
      mmc: mvsdio: use slot-gpio for card detect gpio
      mmc: mvsdio: implement a Device Tree binding
      mmc: mvsdio: add pinctrl integration

 .../devicetree/bindings/mmc/orion-sdio.txt         |  17 +++
 drivers/mmc/host/mvsdio.c                          | 129 ++++++++++-----------
 2 files changed, 80 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
