From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 12:54:46 -0500
Subject: [PATCH v3 0/2] ARM: dts: keystone-k2g: Add I2C support for 66AK2G
Message-ID: <20170908175448.3367-1-fcooper@ti.com>
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

Version 3 changes:
Dropped first patch since it was pulled in.
Remove clk = NULL statements
Fix error path

Franklin S Cooper Jr (2):
  i2c: davinci: Add PM Runtime Support
  dt-bindings: i2c: i2c-davinci: Update binding for 66AK2Gx pwr dm
    property

 .../devicetree/bindings/i2c/i2c-davinci.txt        | 12 ++++
 drivers/i2c/busses/i2c-davinci.c                   | 64 ++++++++++++++++++----
 2 files changed, 65 insertions(+), 11 deletions(-)

-- 
2.9.4.dirty
