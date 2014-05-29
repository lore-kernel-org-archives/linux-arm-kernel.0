From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 May 2014 21:16:25 +0200
Subject: [PATCH v2 0/5] pinctrl: sunxi: Add A31 external interrupts support
Message-ID: <1401390990-5355-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is an attempt at making the external interrupts on the A31 and
the A23 working.

The main difference with the previous code is that there's now several
banks and several parent interrupts, instead of a single bank with a
single parent interrupt in the older SoCs.

Most of the diffstat is to register the new irq pin functions. The
real code additions are those in the core pinctrl driver.

Maxime

Changes from v1:
   - Bail out of the interrupt handler in case of a spurious interrupt
   - Fix the wrong register offset in sunxi_irq_*_reg functions.

Maxime Ripard (5):
  pinctrl: sunxi: Remove irq_mask_ack and use irq_ack instead
  pinctrl: sunxi: Add macro definition for pinctrl with more than one
    interrupt
  pinctrl: sunxi: Declare the number of interrupt banks in the
    descriptor
  pinctrl: sunxi: Declare the interrupt function for the A31
  pinctrl: sunxi: Implement multiple interrupt banks support

 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c   |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c  |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c   |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   | 217 +++++++++++++++++++---------
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c   |   1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       |  81 +++++++----
 drivers/pinctrl/sunxi/pinctrl-sunxi.h       |  46 +++++-
 8 files changed, 241 insertions(+), 108 deletions(-)

-- 
2.0.0
