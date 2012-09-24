From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 24 Sep 2012 08:40:38 +0200
Subject: [PATCH] i.MX25 devicetree support
Message-ID: <1348468841-4331-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following adds devicetree support for the i.MX25. The devicetree
should be fairly complete. The support uses the same clock binding
Shawn already uses for i.MX6, No pinctrl supported (yet).

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      ARM i.MX25: Add devicetree support
      ARM i.MX25: Add devicetree

 .../devicetree/bindings/clock/imx25-clock.txt      |  121 +++++
 arch/arm/boot/dts/imx25.dtsi                       |  469 ++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                          |    7 +
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/clk-imx25.c                      |   56 ++-
 arch/arm/mach-imx/imx25-dt.c                       |   48 ++
 arch/arm/plat-mxc/include/mach/common.h            |    1 +
 7 files changed, 699 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.txt
 create mode 100644 arch/arm/boot/dts/imx25.dtsi
 create mode 100644 arch/arm/mach-imx/imx25-dt.c
