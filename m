From: john@metanate.com (John Keeping)
Date: Wed, 15 Mar 2017 17:46:50 +0000
Subject: [PATCH v2 0/4] pinctrl: rockchip: PREEMPT_RT_FULL fixes
Message-ID: <20170315174654.15128-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an updated version of [1] rebased on top of pinctrl/for-next.
The only change is in patch 1 to remove locking in the new
rockchip_set_schmitt() function.

The aim of the series is to make the Rockchip pinctrl irq_chip
implementation safe for use with RT_FULL which requires that raw
spinlocks are used to avoid sleeping in hardirq context.

[1] https://www.spinics.net/lists/arm-kernel/msg568279.html

John Keeping (4):
  pinctrl: rockchip: remove unnecessary locking
  pinctrl: rockchip: convert to raw spinlock
  pinctrl: rockchip: split out verification of mux settings
  pinctrl: rockchip: avoid hardirq-unsafe functions in irq_chip

 drivers/pinctrl/pinctrl-rockchip.c | 148 ++++++++++++++++++++++---------------
 1 file changed, 87 insertions(+), 61 deletions(-)

-- 
2.12.0.377.gf910686b23.dirty
