From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 24 Jul 2015 12:01:49 +0200
Subject: [PATCH v8 0/2] mfd: flexcom: add a driver for Flexcom
Message-ID: <cover.1437731428.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ChangeLog

v8:
- fix the name of the spi node in the DT example: from spi at f8034400 to
  spi at 2,0
- use the return code of op_property_read_u32_index() instead of -EINVAL
  to report error.
- add Acked-by from Nicolas Ferre

v7:
- read the operating mode from the very first u32 of the reg property from
  the first available child node (should be unique).
- update the DT bindings documentation accordingly.

v6:
- select the operating mode according to the "compatible" DT property of
  the first available child node (should be unique).
- remove the "atmel,flexcom-mode" DT property so the need of a header file
  defining macros for the possible values of this deprecated property.

v5:
- create a header file containing macros used by DT bindings
- use numeric constants instead of strings to select the Flexcom mode
- change the license to "GPL v2"
- update the DT binding documentation to make it more readable and add
  references to USART, SPI and I2C DT binding documentations. remove the
  useless label in the Example section.
- change the register prefix from FX_ to FLEX_ to match the Flexcom
  programmer datasheet.
- rename some variables to make them more understandable.

v4:
- check clk_prepare_enable() return code in atmel_flexcom_probe()
- add a commit message to the DT binding patch

v3:
- remove MODULE_ALIAS()
- add Acked-by from Boris Brezillon and Alexandre Belloni

v2:
- enhance the documentation of DT bindings and change the way the "ranges"
  property is used.
- replace __raw_readl() and __raw_writel() by readl() and writel().
- change the module license to "GPL" for v2 or later
- print the selected flexcom mode after the hardware version

v1:
This series of patches a support to the Atmel Flexcom, a wrapper which
integrates an USART, a SPI controller and a TWI controller. Only one
peripheral can be used at a time. The active function is selected though
the Flexcom Mode Register.

Cyrille Pitchen (2):
  mfd: devicetree: add bindings for Atmel Flexcom
  mfd: atmel-flexcom: add a driver for Atmel Flexible Serial
    Communication Unit

 .../devicetree/bindings/mfd/atmel-flexcom.txt      |  68 +++++++++++++
 drivers/mfd/Kconfig                                |  11 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/atmel-flexcom.c                        | 113 +++++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
 create mode 100644 drivers/mfd/atmel-flexcom.c

-- 
1.8.2.2
