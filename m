From: john@metanate.com (John Keeping)
Date: Fri, 17 Mar 2017 18:24:26 +0000
Subject: [PATCH v3 0/4] pinctrl: rockchip: PREEMPT_RT_FULL fixes
Message-ID: <20170317182430.27400-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of the series is to make the Rockchip pinctrl irq_chip
implementation safe for use with RT_FULL which requires that raw
spinlocks are used to avoid sleeping in hardirq context.

This is the same as version 2 [1] with the 2.1 version of patch 1
included, but I'm rolling it up as a new version so it's simpler to
apply.

[1] https://www.spinics.net/lists/arm-kernel/msg568974.html

John Keeping (4):
  pinctrl: rockchip: remove unnecessary locking
  pinctrl: rockchip: convert to raw spinlock
  pinctrl: rockchip: split out verification of mux settings
  pinctrl: rockchip: avoid hardirq-unsafe functions in irq_chip

 drivers/pinctrl/pinctrl-rockchip.c | 149 +++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 64 deletions(-)

-- 
2.12.0.377.gf910686b23.dirty
