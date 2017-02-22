From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 22 Feb 2017 18:31:43 +0100
Subject: [PATCH 0/3] Improving I2C related support on Armada 3720 DB
Message-ID: <20170222173146.30993-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Now that I2C controller of the Armada 37XX SoCs is supported in the
kernel, this small series improve its usage in Armada 3720 DB board.

The first patch fix the i2c controller nodes.

The second one exposes an i2c device of the Armada 3720 board: a gpio
expander mainly used for power control.

The third one add the driver selection to the defconfig.

Gregory

Gregory CLEMENT (3):
  ARM64: dts: marvell: armada37xx: add address and size property for i2c
    cells
  ARM64: dts: marvell: armada-3720-db: add gpio expander
  arm64: defconfig: enable I2C_PXA

 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 18 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   |  4 ++++
 arch/arm64/configs/defconfig                   |  1 +
 3 files changed, 23 insertions(+)

-- 
2.11.0
