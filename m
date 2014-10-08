From: fkan@apm.com (Feng Kan)
Date: Tue,  7 Oct 2014 17:06:43 -0700
Subject: [PATCH 0/6] APM X-Gene platform mailbox and proxy i2c driver
Message-ID: <1412726809-7525-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set contain the APM X-Gene platform mailbox driver and 
a proxy i2c driver that uses the mailbox driver to communicate with
the i2c bus through the slimpro coprocessor.

Feng Kan (6):
  mailbox: add support for APM X-Gene platform mailbox driver
  Documentation: mailbox: Add APM X-Gene SLIMpro mailbox dts
    documentation
  arm64: dts: mailbox device tree node for APM X-Gene platform.
  i2c: busses: add SLIMpro I2C device driver on APM X-Gene platform
  Documentation: i2c: Add APM X-Gene platform SLIMpro I2C driver
    documentation
  arm64: dts: add proxy I2C device driver on APM X-Gene platform

 .../devicetree/bindings/i2c/i2c-xgene-slimpro.txt  |  20 +
 .../bindings/mailbox/xgene-slimpro-mailbox.txt     |  41 ++
 arch/arm64/boot/dts/apm-storm.dtsi                 |  20 +
 drivers/i2c/busses/Kconfig                         |   9 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-xgene-slimpro.c             | 531 +++++++++++++++++++++
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   1 +
 drivers/mailbox/mailbox-xgene-slimpro.c            | 287 +++++++++++
 9 files changed, 920 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
 create mode 100644 drivers/i2c/busses/i2c-xgene-slimpro.c
 create mode 100644 drivers/mailbox/mailbox-xgene-slimpro.c

-- 
1.9.1
