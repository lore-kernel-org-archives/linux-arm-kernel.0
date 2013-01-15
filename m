From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 Jan 2013 16:37:34 +0800
Subject: [PATCH 0/2] A couple of gpio fixes
Message-ID: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently sent a patch "mmc: slot-gpio: use devm_* managed functions
to ease users" for mmc-next inclusion, and got a error report [1] from
Fengguang (Thanks!), saying it breaks blackfin build.  It seems to me
that the error is caused by devm_gpio_* unnecessary dependency on
GPIOLIB.

While at it, I also include a patch (#1) to fix the 'struct gpio_chip'
declaration warning that's already been there with blackfin build.
And the patch #2 remove the unnecessary dependency between devm_gpio_*
and GPIOLIB to get the reported error fixed.

[1] http://thread.gmane.org/gmane.linux.kernel.mmc/18650

Shawn Guo (2):
  gpio: fix warning of 'struct gpio_chip' declaration
  gpio: devm_gpio_* support should not depend on GPIOLIB

 drivers/gpio/Kconfig       |    3 ++
 drivers/gpio/Makefile      |    3 +-
 include/asm-generic/gpio.h |   91 ++++++++++++++++++++++----------------------
 3 files changed, 50 insertions(+), 47 deletions(-)

-- 
1.7.9.5
