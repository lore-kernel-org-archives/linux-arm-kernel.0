From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 14 May 2014 14:38:14 +0200
Subject: [PATCH v4 0/7] mfd: add basic sun6i A31 PRCM support
Message-ID: <1400071101-30553-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for some functions provided by the PRCM
(Power/Reset/Clock Management) unit:
- AR100, AHB0 and APB0 clocks
- APB0 reset controller

Best Regards,

Boris

Changes since v3:
- split clk drivers into 3 different drivers: ar100, apb0 and apb0_gates
- fix indentation
- add comments to the clk drivers
- select the MFD_SUN6I_PRCM when compiling for SUN6I arch

Changes since v2:
- use devm_ioremap_resource instead of devm_request_and_ioremap
- remove unnecessary header inclusions
- remove info trace when the probe succeed
- rename apb0_timer01 clk into apb0_timer

Changes since v1:
- fix prcm and prcm-clks DT documentation
- remove unneeded iounmap and kfree calls from sunxi_reset_remove function
- rework the AR100 clk implementation

Boris BREZILLON (7):
  reset: sunxi: document sunxi's reset controllers bindings
  reset: sunxi: allow MFD subdevices probe
  mfd: add support for sun6i PRCM (Power/Reset/Clock Management) unit
  mfd: sun6i-prcm: document DT bindings
  clk: sunxi: add PRCM (Power/Reset/Clock Management) clks support
  clk: sunxi: document PRCM clock compatible strings
  ARM: sunxi: dt: add PRCM clk and reset controller subdevices

 Documentation/devicetree/bindings/clock/sunxi.txt  |   3 +
 .../devicetree/bindings/mfd/sun6i-prcm.txt         |  59 ++++++
 .../bindings/reset/allwinner,sunxi-clock-reset.txt |  21 ++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  38 ++++
 arch/arm/mach-sunxi/Kconfig                        |   1 +
 drivers/clk/sunxi/Makefile                         |   2 +
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c           |  99 +++++++++
 drivers/clk/sunxi/clk-sun6i-apb0.c                 |  77 +++++++
 drivers/clk/sunxi/clk-sun6i-ar100.c                | 233 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |   8 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/sun6i-prcm.c                           | 134 ++++++++++++
 drivers/reset/reset-sunxi.c                        |  21 +-
 13 files changed, 694 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
 create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
 create mode 100644 drivers/clk/sunxi/clk-sun6i-apb0-gates.c
 create mode 100644 drivers/clk/sunxi/clk-sun6i-apb0.c
 create mode 100644 drivers/clk/sunxi/clk-sun6i-ar100.c
 create mode 100644 drivers/mfd/sun6i-prcm.c

-- 
1.8.3.2
