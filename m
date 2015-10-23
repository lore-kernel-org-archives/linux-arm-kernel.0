From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Oct 2015 19:51:58 +0900
Subject: [PATCH v2 0/2] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Message-ID: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds two I2C controller drivers.
(they are completely different IPs.)

The first one is a very simple FIFO-less I2C controller,
which is used on some older UniPhier SoCs.

The other one is higher-performance I2C controller with TX/RX FIFO,
used on newer UniPhier SoCs.


Changes in v2:
  - Delete if-block after platform_get_resource()
  - Add I2C_FUNC_SMBUS_EMUL to functionality
  - Add bindings document
  - Add entry to MAINTAINERS
  - Delete if-block after platform_get_resource()
  - Add I2C_FUNC_SMBUS_EMUL to functionality
  - Add bindings document
  - Fix a typo in a comment block

Masahiro Yamada (2):
  i2c: uniphier: add UniPhier FIFO-less I2C driver
  i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver

 .../devicetree/bindings/i2c/i2c-uniphier-f.txt     |  25 +
 .../devicetree/bindings/i2c/i2c-uniphier.txt       |  25 +
 MAINTAINERS                                        |   1 +
 drivers/i2c/busses/Kconfig                         |  16 +
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-uniphier-f.c                | 584 +++++++++++++++++++++
 drivers/i2c/busses/i2c-uniphier.c                  | 441 ++++++++++++++++
 7 files changed, 1094 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier-f.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
 create mode 100644 drivers/i2c/busses/i2c-uniphier-f.c
 create mode 100644 drivers/i2c/busses/i2c-uniphier.c

-- 
1.9.1
