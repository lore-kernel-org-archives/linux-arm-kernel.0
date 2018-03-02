From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri,  2 Mar 2018 11:50:59 +0800
Subject: [PATCH v3 0/3] gpio-keys: Add support for specifying wakeup event
 action
Message-ID: <20180302035102.10084-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.

Changes in v3:
Adding more comments as Brian suggested.

Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.
Specify wakeup event action instead of irq trigger type as Brian
suggested.
Specify wakeup event action instead of irq trigger type as Brian
suggested.

Jeffy Chen (3):
  Input: gpio-keys - add support for wakeup event action
  Input: gpio-keys - allow setting wakeup event action in DT
  arm64: dts: rockchip: Avoid wakeup when inserting the pen

 .../devicetree/bindings/input/gpio-keys.txt        |  8 +++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  2 ++
 drivers/input/keyboard/gpio_keys.c                 | 39 ++++++++++++++++++++++
 include/linux/gpio_keys.h                          |  2 ++
 include/uapi/linux/input-event-codes.h             |  9 +++++
 5 files changed, 60 insertions(+)

-- 
2.11.0
