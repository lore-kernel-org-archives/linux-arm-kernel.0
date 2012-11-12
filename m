From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 12:21:57 +0100
Subject: [PATCH] i.MX25 devicetree support
Message-ID: <1352719321-23541-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following is another round of patches adding i.MX25 devicetree
support. Since the clock numbers are exported to the devicetree I
added a patch to add the missing clock gates to this series, so that
we have to expect less changes (or better additions) to the clock
bindings later. This series is based on and tested with the Ka-Ro
TX25 board for which support is also included in this series.

Sascha

The following changes since commit 53640f41b97792b0889bb70f26f99c06743162a1:

  Merge remote-tracking branch 'arm-soc/imx/multiplatform' into imx25-dt (2012-11-12 12:08:12 +0100)

are available in the git repository at:


  git://git.pengutronix.de/git/imx/linux-2.6.git imx25-dt

for you to fetch changes up to 62300cbf982a5aba4ef22c5c68e1f658e8b324aa:

  ARM i.MX: Add Ka-Ro TX25 devicetree (2012-11-12 12:11:27 +0100)

----------------------------------------------------------------
Sascha Hauer (4):
      ARM i.MX25: Add missing clock gates
      ARM i.MX25: Add devicetree support
      ARM i.MX25: Add devicetree
      ARM i.MX: Add Ka-Ro TX25 devicetree

 .../devicetree/bindings/clock/imx25-clock.txt      |  162 ++++++
 arch/arm/boot/dts/imx25-karo-tx25.dts              |   44 ++
 arch/arm/boot/dts/imx25.dtsi                       |  515 ++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                          |    7 +
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/clk-imx25.c                      |  119 ++++-
 arch/arm/mach-imx/common.h                         |    1 +
 arch/arm/mach-imx/imx25-dt.c                       |   48 ++
 8 files changed, 885 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.txt
 create mode 100644 arch/arm/boot/dts/imx25-karo-tx25.dts
 create mode 100644 arch/arm/boot/dts/imx25.dtsi
 create mode 100644 arch/arm/mach-imx/imx25-dt.c
