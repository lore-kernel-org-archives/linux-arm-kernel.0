From: b32955@freescale.com (Huang Shijie)
Date: Tue, 28 May 2013 14:20:06 +0800
Subject: [PATCH v4 0/6] ARM: imx6q{dl}: add the WEIM driver
Message-ID: <1369722012-6915-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a new driver for WEIM in the imx6q{dl}-sabreauto boards.

The WEIM(Wireless External Interface Module) works like a bus.
You can attach many different devices on it, such as NOR, onenand.

In the case of i.MX6q-sabreauto, only the NOR is connected to WEIM.

v3 --> v4:
	[0] use a more proper pad value for the data pins.
	[1] remove the weim_remove() hook.
	[2] remove the blank line.
	[3] use the lower case for the hex value.
	[4] add returne value for weim_parse_dt().
	[5] rename the pinctrls.

v2 --> v3:
	[0] split the NOR pinctrl.
	[1] make the driver unloaded. change to bool type in Kconfig.
	[2] use the of_platform_populate().
	[3] remove the unused "interrupt" property from the Doc.
v1 --> v2:
	[0] remove used PADs.
	[1] fix the wrong pad values, (thanks Alison Chaiken)
	[2] remove the weim-cs-index.
	[3] add "fsl" for the weim-cs-timing.
	[4] remove the partitions info in the document.
	[5] rewrite the drivers(follow Sascha and Shawn's comments)


Huang Shijie (6):
  drivers: bus: add a new driver for WEIM
  ARM: dts: imx6q{dl}: fix the pin conflict between SPI and WEIM
  ARM: dts: imx6qdl: add more information for WEIM
  ARM: dts: imx6q: add pinctrls for WEIM NOR
  ARM: dts: imx6dl: add pinctrls for WEIM NOR
  ARM: dts: imx6qdl-sabreauto: enable the WEIM NOR

 Documentation/devicetree/bindings/bus/imx-weim.txt |   49 +++++++
 arch/arm/boot/dts/imx6dl-sabreauto.dts             |    9 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |   58 ++++++++
 arch/arm/boot/dts/imx6q-sabreauto.dts              |    9 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   59 +++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   21 +++-
 arch/arm/boot/dts/imx6qdl.dtsi                     |    4 +-
 drivers/bus/Kconfig                                |    9 ++
 drivers/bus/Makefile                               |    1 +
 drivers/bus/imx-weim.c                             |  138 ++++++++++++++++++++
 10 files changed, 353 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
 create mode 100644 drivers/bus/imx-weim.c
