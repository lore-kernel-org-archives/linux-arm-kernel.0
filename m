From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 22:31:13 +0800
Subject: [PATCH 0/6] Add initial imx6dl support
Message-ID: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 DualLite/Solo (imx6dl) is a derivative of i.MX6 Quad/Dual
(imx6q).  These two chips are highly compatible.  The series adds the
initial imx6dl support based on imx6q base.

Linus,

The first two patches has dependency on patch "pinctrl: imx: move
hard-coding data into device tree", which is sitting on IMX tree.  So
can you please give your ACK for me to take them through the same tree?

Thanks,
Shawn

Shawn Guo (6):
  pinctrl: add pinctrl driver for imx6dl
  pinctrl: add pinctrl driver for imx6sl
  ARM: imx: add initial imx6dl support
  ARM: dts: imx: make sabreauto and sabresd common
  ARM: dts: imx: add initial imx6dl-sabresd support
  ARM: dts: imx: add initial imx6dl-sabreauto support

 .../bindings/pinctrl/fsl,imx6dl-pinctrl.txt        |   38 +
 .../bindings/pinctrl/fsl,imx6sl-pinctrl.txt        |   39 +
 arch/arm/Kconfig.debug                             |    4 +-
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/imx6dl-pinfunc.h                 | 1085 ++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-sabreauto.dtsp            |   31 +
 arch/arm/boot/dts/imx6dl-sabresd.dtsp              |   35 +
 arch/arm/boot/dts/imx6dl.dtsip                     |  114 +-
 arch/arm/boot/dts/imx6q-sabreauto.dtsp             |   27 +-
 arch/arm/boot/dts/imx6q-sabresd.dtsp               |   78 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsip          |   38 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsip            |   87 ++
 arch/arm/boot/dts/imx6sl-pinfunc.h                 | 1077 +++++++++++++++++++
 arch/arm/mach-imx/Kconfig                          |    2 +-
 arch/arm/mach-imx/clk-imx6q.c                      |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                     |   30 +-
 arch/arm/mach-imx/mxc.h                            |   11 +
 drivers/pinctrl/Kconfig                            |   12 +-
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-imx6dl.c                   |  459 +++++++++
 drivers/pinctrl/pinctrl-imx6sl.c                   |  365 +++++++
 21 files changed, 3421 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6dl-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6sl-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx6dl-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto.dtsp
 create mode 100644 arch/arm/boot/dts/imx6dl-sabresd.dtsp
 create mode 100644 arch/arm/boot/dts/imx6qdl-sabreauto.dtsip
 create mode 100644 arch/arm/boot/dts/imx6qdl-sabresd.dtsip
 create mode 100644 arch/arm/boot/dts/imx6sl-pinfunc.h
 create mode 100644 drivers/pinctrl/pinctrl-imx6dl.c
 create mode 100644 drivers/pinctrl/pinctrl-imx6sl.c

-- 
1.7.9.5
