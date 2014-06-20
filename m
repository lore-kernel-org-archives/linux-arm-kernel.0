From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Jun 2014 13:48:46 +0200
Subject: [PATCH v9 0/3] arm: Add basic support for Mediatek Cortex-A7 SoCs
Message-ID: <1403264929-21325-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series includes just the patches for the timer driver.
They are rebased against tip/timers/core from the tip repository [0].

The only change applied are line shifts in the OF patch.

I will send the rest of the series as a pull-request.

[0] git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git


Matthias Brugger (3):
  of: Provide function to request and map memory
  clocksource: Add support for the Mediatek SoCs
  dt-bindings: add mtk-timer bindings

 .../bindings/timer/mediatek,mtk-timer.txt          |   18 ++
 drivers/clocksource/Kconfig                        |    5 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/mtk_timer.c                    |  261 ++++++++++++++++++++
 drivers/of/address.c                               |   29 +++
 include/linux/of_address.h                         |    8 +
 6 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
 create mode 100644 drivers/clocksource/mtk_timer.c

-- 
1.7.9.5
