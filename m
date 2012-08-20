From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 Aug 2012 22:19:54 +0800
Subject: [PATCH 0/6] Enable SPARSE_IRQ for mach-mxs
Message-ID: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adopts irq_domain support for mxs icoll and gpio drivers,
enables SPARSE_IRQ, and remove mach/irqs.h for mach-mxs.

As the series depends on mxs/dt branch, I plan to have it go via arm-soc
tree with Linus' ack on the first patch.

Shawn Guo (6):
  gpio/mxs: adopt irq_domain support for mxs gpio driver
  ARM: mxs: retrieve timer irq from device tree
  ARM: mxs: select MULTI_IRQ_HANDLER
  ARM: mxs: adopt irq_domain support for icoll driver
  ARM: mxs: select SPARSE_IRQ
  ARM: mxs: remove mach/irqs.h

 arch/arm/Kconfig                             |    2 +
 arch/arm/boot/dts/imx23.dtsi                 |    5 +-
 arch/arm/boot/dts/imx28.dtsi                 |    5 +-
 arch/arm/mach-mxs/icoll.c                    |   63 ++++++++++++++++++++++----
 arch/arm/mach-mxs/include/mach/common.h      |    3 +-
 arch/arm/mach-mxs/include/mach/entry-macro.S |   35 --------------
 arch/arm/mach-mxs/include/mach/irqs.h        |   32 -------------
 arch/arm/mach-mxs/mach-mxs.c                 |   39 ++--------------
 arch/arm/mach-mxs/timer.c                    |   13 +++++-
 drivers/clk/mxs/clk-imx23.c                  |    2 +-
 drivers/clk/mxs/clk-imx28.c                  |    2 +-
 drivers/gpio/gpio-mxs.c                      |   48 ++++++++++++-------
 12 files changed, 112 insertions(+), 137 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-mxs/include/mach/irqs.h

-- 
1.7.5.4
