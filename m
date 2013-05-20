From: b32955@freescale.com (Huang Shijie)
Date: Mon, 20 May 2013 16:48:56 +0800
Subject: [PATCH 0/6] ARM: imx6q{dl}: add the WEIM driver
Message-ID: <1369039742-10893-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a new driver for WEIM in the imx6q{dl}-sabreauto boards.

The WEIM(Wireless External Interface Module) works like a bus.
You can attach many different devices on it, such as NOR, onenand.

In the case of i.MX6q-sabreauto, only the NOR is connected to WEIM.

Huang Shijie (6):
  drivers: bus: add a new driver for WEIM
  ARM: dts: imx6q{dl}: fix the pin conflict between SPI and WEIM
  ARM: dts: imx6qdl: add more information for WEIM
  ARM: dts: imx6q: add pinctrl for WEIM NOR
  ARM: dts: imx6ql: add a pinctrl for WEIM NOR
  ARM: dts: imx6qdl: enable the WEIM NOR

 Documentation/devicetree/bindings/bus/imx-weim.txt |   69 +++++++++
 arch/arm/boot/dts/imx6dl-sabreauto.dts             |    9 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |   57 ++++++++
 arch/arm/boot/dts/imx6q-sabreauto.dts              |    9 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   58 ++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   23 +++-
 arch/arm/boot/dts/imx6qdl.dtsi                     |    4 +-
 drivers/bus/Kconfig                                |    9 ++
 drivers/bus/Makefile                               |    1 +
 drivers/bus/imx-weim.c                             |  145 ++++++++++++++++++++
 10 files changed, 380 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
 create mode 100644 drivers/bus/imx-weim.c
