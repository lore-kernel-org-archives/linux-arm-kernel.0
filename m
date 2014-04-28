From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 28 Apr 2014 16:58:43 +0200
Subject: [PATCH 0/7] mfd: add basic sun6i A31 PRCM support
Message-ID: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for some functions provided by the PRCM
(Power/Reset/Clock Management) unit:
- AR100, AHB0 and APB0 clocks
- APB0 reset controller

These functions are needed to get the P2WI driver working, but more
subdevices might be added later.

Best Regards,

Boris

Boris BREZILLON (7):
  reset: sunxi: document sunxi's reset controllers bindings
  reset: sunxi: allow MFD subdevices probe
  mfd: add support for sun6i PRCM (Power/Reset/Clock Management) unit
  mfd: sun6i-prcm: document DT bindings
  clk: sunxi: add PRCM (Power/Reset/Clock Management) clks support
  clk: sunxi: document PRCM clock compatible strings
  ARM: sunxi: dt: add PRCM clk and reset controller subdevices

 Documentation/devicetree/bindings/clock/sunxi.txt  |   6 +
 .../devicetree/bindings/mfd/sun6i-prcm.txt         |  71 ++++++
 .../bindings/reset/allwinner,sunxi-clock-reset.txt |  21 ++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  49 ++++
 drivers/clk/sunxi/Makefile                         |   2 +
 drivers/clk/sunxi/clk-sun6i-prcm.c                 | 253 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |   8 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/sun6i-prcm.c                           | 163 +++++++++++++
 drivers/reset/reset-sunxi.c                        |  19 +-
 10 files changed, 592 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
 create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
 create mode 100644 drivers/clk/sunxi/clk-sun6i-prcm.c
 create mode 100644 drivers/mfd/sun6i-prcm.c

-- 
1.8.3.2
