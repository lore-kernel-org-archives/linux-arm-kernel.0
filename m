From: john@metanate.com (John Keeping)
Date: Thu, 23 Mar 2017 10:59:27 +0000
Subject: [PATCH v4 0/4] pinctrl: rockchip: PREEMPT_RT_FULL fixes
Message-ID: <20170323105931.10455-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of the series is to make the Rockchip pinctrl irq_chip
implementation safe for use with RT_FULL which requires that raw
spinlocks are used to avoid sleeping in hardirq context.

v4 is v3 rebased onto pinctrl/devel as of b9c6dcab265e ("pinctrl: rockchip:
rename RK1108 to RV1108").

John Keeping (4):
  pinctrl: rockchip: remove unnecessary locking
  pinctrl: rockchip: convert to raw spinlock
  pinctrl: rockchip: split out verification of mux settings
  pinctrl: rockchip: avoid hardirq-unsafe functions in irq_chip

 drivers/pinctrl/pinctrl-rockchip.c | 149 +++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 64 deletions(-)

-- 
2.12.0.377.gf910686b23.dirty
