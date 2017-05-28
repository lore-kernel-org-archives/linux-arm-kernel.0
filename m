From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 28 May 2017 12:59:34 +0800
Subject: [PATCH 0/2] Add I2C driver for ZTE ZX2967 family SoCs
Message-ID: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Hi Wolfram,

The ZX2967 I2C driver submission had gone through quite a number of
review iterations [1], and seems close to be accepted.  But for some
reason, the ball got dropped from there.  I'm here to pick it up and
hopefully move it forward.

This is basically a resend of the latest posting from Baoyou with
Wolfram's comments on v7 fully addressed.

Changes since v7:
 - Rebase and test on v4.12-rc2.
 - Drop the dev_err() and hardware reset on timeout, which is not really
   necessary.
 - Return -ETIMEDOUT instead of -EIO on timeout.
 - Unify zx2967_i2c_xfer_write_bytes() and zx2967_i2c_xfer_read_bytes()
   into one function zx2967_i2c_xfer_bytes(), and zx2967_i2c_xfer_write()
   and zx2967_i2c_xfer_read() into zx2967_i2c_xfer_msg().

Shawn

[1] https://lkml.org/lkml/2017/2/22/101

Baoyou Xie (2):
  dt: bindings: add documentation for zx2967 family i2c controller
  i2c: zx2967: add i2c controller driver for ZTE's zx2967 family

 .../devicetree/bindings/i2c/i2c-zx2967.txt         |  22 +
 drivers/i2c/busses/Kconfig                         |   9 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-zx2967.c                    | 610 +++++++++++++++++++++
 4 files changed, 642 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
 create mode 100644 drivers/i2c/busses/i2c-zx2967.c

-- 
1.9.1
