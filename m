From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Aug 2013 12:38:46 +0200
Subject: [PATCH 0/2] pinctrl: sunxi: Few more driver fixes
Message-ID: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are a few more fixes for the sunxi pinctrl driver.

It fixes yet another brown-paper-bag-bug in the irq set_type function, and adds
the missing locking.

It should probably go into 3.11, and requires the "pinctrl: sunxi: Fix gpio_set
behaviour" patch I sent previously.

Thanks,
Maxime

Maxime Ripard (2):
  pinctrl: sunxi: Read register before writing to it in irq_set_type
  pinctrl: sunxi: Add spinlocks

 drivers/pinctrl/pinctrl-sunxi.c | 60 ++++++++++++++++++++++++++++++++++++++---
 drivers/pinctrl/pinctrl-sunxi.h |  2 ++
 2 files changed, 58 insertions(+), 4 deletions(-)

-- 
1.8.3.4
