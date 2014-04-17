From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 17 Apr 2014 11:40:10 +0200
Subject: [PATCH v2 0/2] regmap: support regmap over SMBus
Message-ID: <1397727612-32103-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for remap over SMBus in case your i2c
adapter does not support regular I2C transfers.

SMBus is a subset of the I2C protocol, often used to access registers
on external devices.

I2C adapters are able to access SMBus devices thanks to the SMBus
emulation layer. In the other hand SMBus adapters may not provide
regular I2C transfers, and thus you may not be able to expose a regmap
if your device is connected to such kind of adapter.
Hence why we need this regmap over SMBus implementation.

Best Regards,

Boris

Changes since v1:
 - add reg_read/reg_write callbacks to the regmap_bus struct

Boris BREZILLON (2):
  regmap: add reg_read/reg_write callbacks to regmap_bus struct
  regmap: i2c: fallback to SMBus if the adapter does not support
    standard I2C

 drivers/base/regmap/regmap-i2c.c | 104 ++++++++++++++++++++++++++++++++++++++-
 drivers/base/regmap/regmap.c     |  26 ++++++++++
 include/linux/regmap.h           |   6 +++
 3 files changed, 134 insertions(+), 2 deletions(-)

-- 
1.8.3.2
