From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  7 Jun 2013 17:42:21 +0200
Subject: [PATCH 0/2] i2c-mv64xxx: Add I2C Transaction Generator support
Message-ID: <1370619743-15245-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch set adds support for the I2C Transaction Generator which
offloads CPU from managing I2C transfer step by step. This feature is
currently only available on the I2C controller IP embedded in the
Armada XP SoC. That's why usage of this mechanism is optional and
activated through device tree.

The first patch modifies the driver itself and should go through i2c
subsystem.

Due to the recent changes in i2c-mv64xxx.c file caused by Russell
King's fixes, I based this patch on the for-next branch of the i2c git
repository.

The second patch updates the device tree to be able to use this new
feature and should go through mvebu subsystem.

The 2 patches are independents for building or even at runtime, but of
course we need both of them to be able to use the I2C Transaction
Generator on the Armada XP SoC.

Thanks

Gregory CLEMENT (1):
  ARM: dts: mvebu: Add the i2c-bridge capability to the mv64xxx-i2c

Zbigniew Bodek (1):
  i2c-mv64xxx: Add I2C Transaction Generator support

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |   6 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |   2 -
 arch/arm/boot/dts/armada-370.dtsi                  |   8 ++
 arch/arm/boot/dts/armada-xp.dtsi                   |  10 ++
 drivers/i2c/busses/i2c-mv64xxx.c                   | 143 ++++++++++++++++++++-
 5 files changed, 163 insertions(+), 6 deletions(-)

-- 
1.8.1.2
