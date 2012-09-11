From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Sep 2012 20:02:48 +0800
Subject: [GIT PULL 2/2] imx6q clk device tree lookup
In-Reply-To: <1347364968-27496-1-git-send-email-shawn.guo@linaro.org>
References: <1347364968-27496-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347364968-27496-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-clk-dt-lookup

for you to fetch changes up to 0e87e0436c0cc3954eb62181a96d7217ca955a4f:

  ARM: imx6q: replace clk_register_clkdev with clock DT lookup (2012-09-11 19:16:14 +0800)

----------------------------------------------------------------
imx-clk-dt-lookup

It replaces the clk_register_clkdev in imx6q clock driver with DT
lookup.  It depends on Mike's clk-3.7 branch.

When it gets merged together with imx-dt-3.7, there is a trivial
conflict on arch/arm/boot/dts/imx6q.dtsi.

----------------------------------------------------------------
Shawn Guo (1):
      ARM: imx6q: replace clk_register_clkdev with clock DT lookup

 .../devicetree/bindings/clock/imx6q-clock.txt      |  222 ++++++++++++++++++++
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    1 +
 arch/arm/boot/dts/imx6q.dtsi                       |   73 ++++++-
 arch/arm/mach-imx/clk-imx6q.c                      |   44 +---
 arch/arm/mach-imx/mach-imx6q.c                     |    1 -
 5 files changed, 291 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt
