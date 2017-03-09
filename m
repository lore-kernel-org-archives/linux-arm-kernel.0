From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Mar 2017 18:52:55 +0100
Subject: [PATCH v4 0/3] Add EHCI support for Armada 37xx
Message-ID: <20170309175258.20076-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The EHCI controller in the Armada 37xx SoCs is the one used on many
other mvebu SoCs such as the orion5x, the kirkwood, or the
armada. However, for Armada 37xx an extra initialization step is
needed: this is the purpose of the first patch.

The second patch allows to build the driver for the ARM64 Armada SoCs.

The last one enables the EHCI in the device tree.

This forth version really takes into account the review from Alan Stern.
Again sorry for the noise.

Thanks,

Gregory

Changelog:
v3-> v4:
- Remove the _SHIFT define and use their value directly, suggested by
  Alan Stern
- Remove unnecessary error message in ehci_orion_drv_reset() ,
  suggested by Alan Stern
- Exit ehci_orion_drv_reset() if ehci_setup() failed, suggested by
  Alan Stern

v2-> v3:
- Add Reviewed-by flag from  Andrew Lunn

v1 -> v2:
- Fix typo in commit log of the patch 1, suggested by Andrew Lunn
- Fix wording in the device tree binding documenation, suggested by
  Andrew Lunn
- Make new define symbol name more clear by adding _SHIFT to the end,
  suggested by Andrew Lunn
- Use a full first name + last name for the Signed-off-by and the
  Authorship i oatch 1, suggested by Thomas Petazzoni.
- Improve the commit log of the patch 2, suggested by Andrew Lunn
- Fix Kconfig logic, suggested by Andrew Lunn

Gregory CLEMENT (2):
  usb: host: Allow to build ehci orion with mvebu SoCs
  ARM64: dts: marvell: armada-37xx: Add USB2 node

Hua Jing (1):
  usb: orion-echi: Add support for the Armada 3700

 .../devicetree/bindings/usb/ehci-orion.txt         |  4 ++-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |  6 ++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  7 +++++
 drivers/usb/host/Kconfig                           |  2 +-
 drivers/usb/host/ehci-orion.c                      | 36 ++++++++++++++++++++++
 5 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.11.0
