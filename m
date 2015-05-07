From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 8 May 2015 01:35:52 +0800
Subject: [PATCH V8 0/6] Add Freescale i.mx7d support
Message-ID: <1431020158-13789-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Add basic support for chip imx7d.
 - MSL
 - Clock support. All clock enabled.
 - pinctrl support
 - SD Card support

Change from v7 to v8
 - exclude patchs already accepted.
 - Remove SOC_IMX7
 - Remove static map
 - Remove #include <linux/phy.h>
 - Remove .restart        = mxc_restart,
 - Remove mx7d.h
 - consistent indetation in imx7d.dtsi
 - Change document remove  "ipp_di0" and "ipp_di1"
 - Remove GPC because needn't it now, will added back at SMP enable patch
 - Remove imx21-uart compatible string
 - use i.mx6sx timer compatible string, so remove time.c change
 - correct typo imx6sx
 - dt file add cpu1

Change from v6 to v7
 - Move clk to driver/clk/imx
 - Remove iomux-lpsr part
 - Remove parents clocks node in imx7d.dtsi

Change from v5 to v6
 - dual license for dts
 - fix typo statue
 - Remove smp_operations
 - Remove GPT check cpu_is_mx7() by use old compatible mode
 - Remove dts arch_timer part, which not used in this patch series
 - correct GIC reg map

Change from v4 to v5
 - Remove imx7d_map_io()
 - Remove  clk_register_clkdev(clks[IMX7D_GPT1_ROOT_CLK], "ipg", "imx-gpt.0");
 - Remove  clk_register_clkdev(clks[IMX7D_GPT_3M_CLK], "gpt_3m", "imx-gpt.0");
 - Add comment about enable all clock
 - Add Type IMX_PLLV3_ENET_IMX7 and remove cpu_is_imx7d()

Change from v3 to v4
 - Fixed the problem review by Russel king.
   Remove __mxc_arch_type
   Remove MXC_ARCH_CA7
   use new smp_operation for ca7 platform
 - imx7d.dtsi remove unecessary part for bring up
 - imx7d-sdb.dsi, just enable uart i2c and sd card
 - Add device tree binding document for timer, clock and pinctrl

Change from v2 to v3
  - remove unsupport part in imx7d-sdb.dtb

Change from V1 to V2:
  - split patch1 to three small one to avoid 100k maillist limitation.
  - fix imx7d.dtsi code style problem

Anson Huang (1):
  ARM: imx: add msl support for imx7d

Frank Li (5):
  Document: dt: binding: imx: update document for imx7d support
  ARM: dts: add imx7d soc dtsi file
  ARM: imx: add imx7d clk tree support
  arm: dts: add imx7d-sdb support
  ARM: config: imx_v6_v7_defconfig add imx7d support

 .../devicetree/bindings/clock/imx7d-clock.txt      |  13 +
 .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         |  27 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx7d-sdb.dts                    | 420 ++++++++++
 arch/arm/boot/dts/imx7d.dtsi                       | 486 +++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 arch/arm/mach-imx/Kconfig                          |   7 +
 arch/arm/mach-imx/Makefile                         |   1 +
 arch/arm/mach-imx/anatop.c                         |   5 +-
 arch/arm/mach-imx/cpu.c                            |   3 +
 arch/arm/mach-imx/mach-imx7d.c                     |  43 +
 arch/arm/mach-imx/mxc.h                            |   8 +-
 drivers/clk/imx/Makefile                           |   1 +
 drivers/clk/imx/clk-imx7d.c                        | 886 +++++++++++++++++++++
 drivers/clk/imx/clk-pllv3.c                        |  14 +-
 drivers/clk/imx/clk.h                              |   9 +
 include/dt-bindings/clock/imx7d-clock.h            | 450 +++++++++++
 17 files changed, 2373 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx7d-sdb.dts
 create mode 100644 arch/arm/boot/dts/imx7d.dtsi
 create mode 100644 arch/arm/mach-imx/mach-imx7d.c
 create mode 100644 drivers/clk/imx/clk-imx7d.c
 create mode 100644 include/dt-bindings/clock/imx7d-clock.h

-- 
1.9.1
