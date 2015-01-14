From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 Jan 2015 00:15:05 +0100
Subject: [PATCHv3 0/2] Driver for TI tlc59116 16 Channel i2c LED driver
Message-ID: <1421277308-3477-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is a driver for the TI tlc59116 16 Channel i2c LED
driver. This driver is used on the Belkin WRT1900AC access point and
the C code is derived from code Belkin contributed to OpenWRT.
However it has been extensively re-written, and a device tree binding
added to replace platform data.

Cc: Matthew.Fatheree at belkin.com

Since v2:
       Remove incorrect /* Mode register ? */ comment
       Parenthesis around the macro arguments
       Converted many signed variables into unsigned
       Saved an initialization

Since v1:
      s/uint8_t/u8/g
      Remove empty line
      Removed #gpio-cells
      Added select REGMAP_I2C
      Sorted #includes into alphabetic order
      Added missing MODULE_DEVICE_TABLE(of, ...)
      Check return value of regmap_write()
      Simplified tlc59116_set_mode()

Andrew Lunn (2):
  leds: tlc59116: Document binding for the TI 16 Channel i2c LED driver
  leds: tlc59116: Driver for the TI 16 Channel i2c LED driver

 .../devicetree/bindings/leds/leds-tlc59116.txt     |  41 ++++
 drivers/leds/Kconfig                               |   7 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-tlc59116.c                       | 253 +++++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc59116.txt
 create mode 100644 drivers/leds/leds-tlc59116.c

-- 
2.1.3
