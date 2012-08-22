From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Aug 2012 21:36:26 +0800
Subject: [PATCH v2 0/4] Move imx6q/28/23 clock lookup over to device tree
Message-ID: <1345642590-29905-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change since v1:
* Rewrite of_clk_src_onecell_get() to get the clk using the index
  provided by device tree and the clks array provided by clock driver.
  Then we can save that big clock name list in dts and the string
  matching which is relatively slow. 

Shawn Guo (4):
  clk: add of_clk_src_onecell_get() support
  ARM: imx6q: replace clk_register_clkdev with clock DT lookup
  clk: mxs: replace imx28 clk_register_clkdev with clock DT lookup
  clk: mxs: replace imx23 clk_register_clkdev with clock DT lookup

 .../devicetree/bindings/clock/imx23-clock.txt      |   76 +++++++
 .../devicetree/bindings/clock/imx28-clock.txt      |   99 +++++++++
 .../devicetree/bindings/clock/imx6q-clock.txt      |  222 ++++++++++++++++++++
 arch/arm/boot/dts/imx23.dtsi                       |   16 ++-
 arch/arm/boot/dts/imx28.dtsi                       |   33 +++-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    1 +
 arch/arm/boot/dts/imx6q.dtsi                       |   73 ++++++-
 arch/arm/mach-imx/clk-imx6q.c                      |   44 +----
 arch/arm/mach-imx/mach-imx6q.c                     |    1 -
 drivers/clk/clk.c                                  |   14 ++
 drivers/clk/mxs/clk-imx23.c                        |   55 +----
 drivers/clk/mxs/clk-imx28.c                        |  113 +---------
 include/linux/clk-provider.h                       |    5 +
 13 files changed, 550 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt

-- 
1.7.5.4
