From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Thu, 20 Sep 2018 18:14:19 +0200
Subject: [RFC PATCH 0/4] i2c: core: introduce master_xfer_irqless
Message-ID: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To keep the discussion about master_xfer_irqless going, I post here a
draft how I envision the changes to the I2C core. They are only build
tested. I am unsure if I can test them on hardware before next week, so
I'll send them around as RFC already, so people can get an idea and
comment. Maybe Stefan has some bandwidth to test his imx driver
implementation on top of this?

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/xfer_irqless

Happy hacking and thanks for all the input to this,

   Wolfram


Wolfram Sang (4):
  i2c: core: remove outdated DEBUG output
  i2c: core: remove level of indentation in i2c_transfer
  i2c: core: use I2C locking behaviour also for SMBUS
  i2c: core: introduce master_xfer_irqless callback

 drivers/i2c/i2c-core-base.c  | 44 +++++++++++++-----------------------
 drivers/i2c/i2c-core-smbus.c |  7 +++++-
 drivers/i2c/i2c-core.h       | 12 ++++++++++
 include/linux/i2c.h          | 10 +++++---
 4 files changed, 41 insertions(+), 32 deletions(-)

-- 
2.18.0
