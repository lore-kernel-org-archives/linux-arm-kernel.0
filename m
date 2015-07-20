From: vigneshr@ti.com (Vignesh R)
Date: Mon, 20 Jul 2015 10:20:12 +0530
Subject: [PATCH v2 0/2] pixcir_i2c_ts: Add optional wakeup irq support
Message-ID: <1437367814-27785-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On am437x-gp-evm, pixcir_i2c_tsc can wake-up system from low power
state via pinctrl and IO daisy chain mechanism. This patch series add
support for such optional wake up interrupt to be handled via recently
introduced generic wake irq handling framework.

Tested on am437x-gp-evm, with some out of tree patches to support
suspend/resume on am437x.


Vignesh R (2):
  input: touchscreen: pixcir_i2c_ts: Add support for optional wakeup
    interrupt
  ARM: dts: AM437x-gp-evm: Add wakeup interrupt source for
    pixcir_i2c_tsc

 arch/arm/boot/dts/am437x-gp-evm.dts       |  4 ++++
 drivers/input/touchscreen/pixcir_i2c_ts.c | 17 +++++++++++++----
 include/linux/input/pixcir_ts.h           |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.4.5
