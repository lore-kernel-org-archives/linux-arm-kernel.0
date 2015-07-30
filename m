From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 30 Jul 2015 17:12:19 +0900
Subject: [PATCH 0/3] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Message-ID: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds two I2C controller drivers.
(they are completely different IPs.)

The first one is a very simple FIFO-less I2C controller,
which is used on some older UniPhier SoCs.

The other one is higher-performance I2C controller with TX/RX FIFO,
used on newer UniPhier SoCs.



Masahiro Yamada (3):
  i2c: uniphier: add UniPhier FIFO-less I2C driver
  i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver
  i2c: uniphier: add bindings for UniPhier I2C controllers

 .../devicetree/bindings/i2c/i2c-uniphier.txt       |  46 ++
 drivers/i2c/busses/Kconfig                         |  16 +
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-uniphier-f.c                | 589 +++++++++++++++++++++
 drivers/i2c/busses/i2c-uniphier.c                  | 446 ++++++++++++++++
 5 files changed, 1099 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
 create mode 100644 drivers/i2c/busses/i2c-uniphier-f.c
 create mode 100644 drivers/i2c/busses/i2c-uniphier.c

-- 
1.9.1
