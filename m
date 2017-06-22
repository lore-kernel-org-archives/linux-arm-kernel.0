From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Jun 2017 20:56:53 +0800
Subject: [PATCH v2 0/2] Add I2C driver for ZTE ZX2967 family SoCs
Message-ID: <1498136215-8102-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It's the second posting of the patches adding I2C driver for ZTE ZX2967
family SoCs.  Thanks a lot for Wolfram's review comments on v1 patch,
which helps identify issues with NACK handling.

Changes for v2:
 - Add COMPILE_TEST for Kconfig option dependency.
 - Drop warning message for unsupported SMBus transfer, since the driver
   will fall back to emulate them via I2C anyway.
 - Kill ZX2967_I2C_FUNCS define by returning I2C_FUNC_XXX directly.
 - Drop error message for i2c_add_numbered_adapter() check, since the
   core will do the reporting.
 - Drop the error checking from zx2967_i2c_reset_hardware() which is
   useless now, and add it into irq handler for proper NACK handling.

Baoyou Xie (2):
  dt: bindings: add documentation for zx2967 family i2c controller
  i2c: zx2967: add i2c controller driver for ZTE's zx2967 family

 .../devicetree/bindings/i2c/i2c-zx2967.txt         |  22 +
 drivers/i2c/busses/Kconfig                         |   9 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-zx2967.c                    | 609 +++++++++++++++++++++
 4 files changed, 641 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
 create mode 100644 drivers/i2c/busses/i2c-zx2967.c

-- 
1.9.1
