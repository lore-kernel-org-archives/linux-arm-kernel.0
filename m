From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu,  8 Mar 2018 15:32:10 +0800
Subject: [PATCH v5 0/3] gpio-keys: Add support for specifying wakeup event
 action
Message-ID: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.

Changes in v5:
Remove unneeded irq_wake flag as Andy suggested.

Changes in v4:
Add dt-binding gpio-keys.h, stop saving irq trigger type, add enable/disable wakeup helpers as Dmitry suggested.
Include dt-binding gpio-keys.h

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
  arm64: dts: rockchip: kevin: Avoid wakeup when inserting the pen

 .../devicetree/bindings/input/gpio-keys.txt        |  8 +++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  3 ++
 drivers/input/keyboard/gpio_keys.c                 | 63 ++++++++++++++++++++--
 include/dt-bindings/input/gpio-keys.h              | 13 +++++
 include/linux/gpio_keys.h                          |  2 +
 5 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/input/gpio-keys.h

-- 
2.11.0
