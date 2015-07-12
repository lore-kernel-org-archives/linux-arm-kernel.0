From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 13 Jul 2015 00:47:20 +0200
Subject: [PATCH 0/2] I2C support for NXP LPC18xx family
Message-ID: <1436741242-13489-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a I2C driver and documentation for the I2C
peripheral found on many NXP LPC MCUs.

The driver is a rework of an old driver by Kevin Wells. It has been
modified to support modern resource allocation, device tree and
generally cleaned up. Driver was originally written to support the
LPC2xxx platforms.

Patches based on v4.2-rc1 and tested on Embedded Artists' LPC4357
Developer's Kit with several I2C devices.

Joachim Eastwood (2):
  i2c: add i2c-lpc2k driver
  doc: dt: add documentation for i2c-lpc2k

 .../devicetree/bindings/i2c/i2c-lpc2k.txt          |  33 ++
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-lpc2k.c                     | 551 +++++++++++++++++++++
 4 files changed, 595 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt
 create mode 100644 drivers/i2c/busses/i2c-lpc2k.c

-- 
1.8.0
