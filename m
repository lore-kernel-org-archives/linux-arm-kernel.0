From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri,  9 Feb 2018 19:55:07 +0800
Subject: [PATCH 0/3] gpio-keys: Add support for specifying wakeup interrupt
 trigger type
Message-ID: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.


Jeffy Chen (3):
  Input: gpio-keys - add support for wakeup interrupt trigger type
  Input: gpio-keys - allow setting wakeup interrupt trigger type in DT
  arm64: dts: rockchip: Avoid wakeup when inserting the pen

 .../devicetree/bindings/input/gpio-keys.txt          |  9 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts    |  2 ++
 drivers/input/keyboard/gpio_keys.c                   | 20 ++++++++++++++++++--
 include/linux/gpio_keys.h                            |  2 ++
 4 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.11.0
