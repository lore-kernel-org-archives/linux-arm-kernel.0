From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 16 Aug 2015 20:10:15 +0200
Subject: [PATCH v2 0/2] I2C support for NXP LPC18xx family
Message-ID: <1439748617-7683-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a I2C driver and documentation for the I2C
peripheral found on many NXP LPC MCUs.

The driver is a rework of an old driver by Kevin Wells. It has been
modified to support modern resource allocation, device tree and
generally cleaned up. Driver was originally written to support the
LPC2xxx platforms.

Patches based on i2c/for-next and tested on Embedded Artists' LPC4357
Dev Kit and Hitex LPC4350 Eval board with several I2C devices.

This version address comments from Wolfram Sang.

Changes since v1:
 - remove dev_dbg() leftovers from development/debugging
 - use i2c_add_adapter
 - change return value on NACK and arb lost
   (I think all the others should be okay as they are)
 - fix 80 char warnings (involved s/reg_base/base)
 - rebase on i2c/for-next

Joachim Eastwood (2):
  i2c: add i2c-lpc2k driver
  doc: dt: add documentation for nxp,lpc1788-i2c

 .../devicetree/bindings/i2c/i2c-lpc2k.txt          |  33 ++
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-lpc2k.c                     | 513 +++++++++++++++++++++
 4 files changed, 557 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt
 create mode 100644 drivers/i2c/busses/i2c-lpc2k.c

-- 
1.8.0
