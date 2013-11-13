From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 13 Nov 2013 20:11:16 +0100
Subject: [PATCH 0/3] devicetree includes for i.MX5 clocks
Message-ID: <1384369879-11878-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces devicetree includes for the i.MX5
SoC clocks. It makes devicetrees easier to read for humans and
less error prone.

The series is spun against Shawns for-next branch, as there are
already some clock related patches in there. I would like to
see those patches sitting in -next for a while.

Lucas Stach (3):
  clk: imx5: introduce DT includes for clock provider
  ARM: imx53: use clock defines in DTS files
  ARM: imx51: use clock defines in DTS files

 .../devicetree/bindings/clock/imx5-clock.txt       | 196 +----
 arch/arm/boot/dts/imx51.dtsi                       |  98 ++-
 arch/arm/boot/dts/imx53-m53evk.dts                 |   2 +-
 arch/arm/boot/dts/imx53-mba53.dts                  |   2 +-
 arch/arm/boot/dts/imx53-qsb.dts                    |   2 +-
 arch/arm/boot/dts/imx53.dtsi                       | 122 ++--
 arch/arm/mach-imx/clk-imx51-imx53.c                | 786 ++++++++++-----------
 include/dt-bindings/clock/imx5-clock.h             | 202 ++++++
 8 files changed, 718 insertions(+), 692 deletions(-)
 create mode 100644 include/dt-bindings/clock/imx5-clock.h

-- 
1.8.4.2
