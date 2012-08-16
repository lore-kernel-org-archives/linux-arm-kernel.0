From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 16 Aug 2012 16:08:44 +0800
Subject: [PATCH 0/2] Move imx6q clock lookup over to device tree
Message-ID: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds a generic of_clk_src_onecell_get() function into clock
framework, and then moves imx6q clock lookup over to device tree, so
that any new clock lookup to be added at later time does not need to
patch kerenel.

Shawn Guo (2):
  clk: add of_clk_src_onecell_get() support
  ARM: imx6q: replace clk_register_clkdev with clock DT lookup

 .../devicetree/bindings/clock/imx6q-clock.txt      |  223 +++++++++++++++++
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  261 +++++++++++++++++++-
 arch/arm/mach-imx/clk-imx6q.c                      |   41 +---
 arch/arm/mach-imx/mach-imx6q.c                     |    1 -
 drivers/clk/clk.c                                  |   15 ++
 include/linux/clk-provider.h                       |    1 +
 7 files changed, 493 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt

-- 
1.7.5.4
