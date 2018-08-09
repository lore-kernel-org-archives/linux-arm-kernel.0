From: abel.vesa@nxp.com (Abel Vesa)
Date: Thu,  9 Aug 2018 17:45:37 +0300
Subject: [PATCH v3 0/4] Add i.MX8MQ clock driver
Message-ID: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is basically just a resend of the following patchset:

https://www.spinics.net/lists/linux-clk/msg23141.html

I've just updated the patchset and implemented Shawn's
and Aisheng's comments.

I hope I haven't missed any of their comments.

Lucas Stach (4):
  dt-bindings: add binding for i.MX8MQ CCM
  clk: imx: add fractional PLL output clock
  clk: imx: add SCCG PLL type
  clk: imx: add clock driver for i.MX8MQ CCM

 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 drivers/clk/imx/Makefile                           |   5 +-
 drivers/clk/imx/clk-frac-pll.c                     | 230 ++++++
 drivers/clk/imx/clk-imx8mq.c                       | 856 +++++++++++++++++++++
 drivers/clk/imx/clk-sccg-pll.c                     | 231 ++++++
 drivers/clk/imx/clk.h                              |  48 ++
 include/dt-bindings/clock/imx8mq-clock.h           | 629 +++++++++++++++
 7 files changed, 2018 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

-- 
2.7.4
