From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 2 Aug 2017 17:17:49 -0500
Subject: [PATCH 0/4] ARM: dts: keystone-k2g: Add I2C support for 66AK2G
Message-ID: <20170802221753.13786-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C support to 66AK2G. Primary requirement is to add PM
Runtime support to the driver.

This has been tested on following platforms by performing simple i2c test
such as i2c detect and reading on board i2c devices:
K2G GP evm
OMAPL138
K2L GP EVM

and boot tested on:
K2E GP EVM
K2HK GP EVM

Franklin S Cooper Jr (3):
  i2c: davinci: Preserve return value of devm_clk_get
  i2c: davinci: Add PM Runtime Support
  dt-bindings: i2c: i2c-davinci: Update binding for 66AK2Gx pwr dm
    property

Vitaly Andrianov (1):
  ARM: dts: keystone-k2g: Add I2C nodes

 .../devicetree/bindings/i2c/i2c-davinci.txt        | 12 +++++
 arch/arm/boot/dts/keystone-k2g.dtsi                | 36 +++++++++++++
 drivers/i2c/busses/i2c-davinci.c                   | 63 ++++++++++++++++++----
 3 files changed, 102 insertions(+), 9 deletions(-)

-- 
2.9.4.dirty
