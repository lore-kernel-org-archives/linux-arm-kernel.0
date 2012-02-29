From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Feb 2012 09:20:51 +0100
Subject: [PATCH] Add devicetree support for i.MX27 SoCs
Message-ID: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I created the following mainly out of curiosity to find out what's
missing to support a new i.MX SoC in the devicetree. It turned out
it's not much thanks to the driver bindings which already exist for
the bigger i.MXes. So here it is.

Sascha

Sascha Hauer (3):
      ARM i.MX27: Add devicetree support
      ARM i.MX: Add phytec phycore-i.MX27 (aka pcm038) devicetree support
      devicetree-bindings: Add documentation for i.MX generic boards

 Documentation/devicetree/bindings/arm/fsl.txt |   22 +++
 arch/arm/boot/dts/imx27-phytec-phycore.dts    |   76 +++++++++
 arch/arm/boot/dts/imx27.dtsi                  |  217 +++++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                     |    8 +
 arch/arm/mach-imx/Makefile                    |    1 +
 arch/arm/mach-imx/clock-imx27.c               |   18 ++
 arch/arm/mach-imx/imx27-dt.c                  |   89 ++++++++++
 arch/arm/plat-mxc/include/mach/common.h       |    1 +
 8 files changed, 432 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycore.dts
 create mode 100644 arch/arm/boot/dts/imx27.dtsi
 create mode 100644 arch/arm/mach-imx/imx27-dt.c
