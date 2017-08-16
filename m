From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 16 Aug 2017 17:17:12 -0500
Subject: [PATCH v2 0/3] ARM: dts: keystone-k2g: Add I2C support for 66AK2G
Message-ID: <20170816221715.15027-1-fcooper@ti.com>
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

Version 2 changes:
Moved ordering of pm runtime calls

Franklin S Cooper Jr (3):
  i2c: davinci: Preserve return value of devm_clk_get
  i2c: davinci: Add PM Runtime Support
  dt-bindings: i2c: i2c-davinci: Update binding for 66AK2Gx pwr dm
    property

 .../devicetree/bindings/i2c/i2c-davinci.txt        | 12 ++++
 drivers/i2c/busses/i2c-davinci.c                   | 64 +++++++++++++++++++---
 2 files changed, 67 insertions(+), 9 deletions(-)

-- 
2.9.4.dirty
