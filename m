From: abel.vesa@nxp.com (Abel Vesa)
Date: Wed, 7 Nov 2018 12:38:05 +0000
Subject: [PATCH v12 0/5] Add i.MX8MQ clock driver
Message-ID: <1541594266-16712-1-git-send-email-abel.vesa@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So this is all cleaned up now. The switch from clk to clk_hw registration
is done only for the newly added clock types because changing the older
ones will imply a bigger change. I will spend some time on that, but this
can't be delayed by that since this is needed in order to boot up.

Here is a link to the 11th version:
https://lkml.org/lkml/2018/10/10/292

Changes since v11:
 * changed the authorship of the CCM driver
     since it has changed drastically from the original version.
 * changed the CCM driver to platform driver
 * changed all new clock types to clk_hw based registration
 * fixed the all other comments from Stephen

Abel Vesa (2):
  clk: imx: Add imx composite clock
  clk: imx: Add clock driver for i.MX8MQ CCM

Lucas Stach (3):
  dt-bindings: add binding for i.MX8MQ CCM
  clk: imx: add fractional PLL output clock
  clk: imx: Add SCCG PLL type

 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-composite-8m.c                 | 178 +++++++
 drivers/clk/imx/clk-frac-pll.c                     | 221 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 589 +++++++++++++++++++++
 drivers/clk/imx/clk-sccg-pll.c                     | 256 +++++++++
 drivers/clk/imx/clk.h                              |  64 +++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 ++++++++++++++
 8 files changed, 1728 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 drivers/clk/imx/clk-composite-8m.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

-- 
2.7.4
