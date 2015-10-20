From: luisbg@osg.samsung.com (Luis de Bethencourt)
Date: Tue, 20 Oct 2015 15:16:26 +0100
Subject: [RESEND PATCH 0/4] i2c: Fix module autoload for OF platform drivers
Message-ID: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a resend of this patch series. It was posted on September 17. [0]

These patches add the missing MODULE_DEVICE_TABLE() for OF to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

The 4th patch of the series is Acked-by Linus Walleij.

[0] https://lkml.org/lkml/2015/9/17/558
[1] https://lkml.org/lkml/2015/9/17/559
[2] https://lkml.org/lkml/2015/9/17/560
[3] https://lkml.org/lkml/2015/9/17/561
[4] https://lkml.org/lkml/2015/9/17/562

Thanks,
Luis

Luis de Bethencourt (4):
  i2c: ibm-iic: Fix module autoload for OF platform driver
  i2c: meson: Fix module autoload for OF platform driver
  i2c: rk3x: Fix module autoload for OF platform driver
  i2c: stu300: Fix module autoload for OF platform driver

 drivers/i2c/busses/i2c-ibm_iic.c | 1 +
 drivers/i2c/busses/i2c-meson.c   | 1 +
 drivers/i2c/busses/i2c-rk3x.c    | 1 +
 drivers/i2c/busses/i2c-stu300.c  | 1 +
 4 files changed, 4 insertions(+)

-- 
2.5.3
