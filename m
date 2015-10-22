From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Fri, 23 Oct 2015 07:46:14 +0800
Subject: [PATCH v2 0/3] Add basic support for Allwinner A83T SOC
Message-ID: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds very basic support for Allwinner A83T SOC.
Clock, peripherals, smp support will be added later.

Allwinner A83T is octa-core cortex-a7 based SoC.
It's clock control unit and prcm, pinmux are different from previous sun8i
series.
Its processor cores are arragned in two clusters 4 cores each,
similar to A80.

Note: A83T pincontroller patch is already applied by Linus, so not added in this
patch.

changes from v1->v2:
1. used UART0 header with PB9, PB10 pins.
2. removed unnecessary includes and comments from dtsi.
3. arranged nodes in alphabatical order.
4. arrnaged compatible in alphabatical order.
5. changed cpu nodes to use cpu at 100 -cpu at -103.
6. changed dts filename.

Vishnu Patekar (3):
  ARM: sunxi: Introduce Allwinner for A83T support
  ARM: dts: sun8i: Add Allwinner A83T dtsi
  ARM: dts: sun8i: Add A83T HomletV2 Board by Allwinner

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |  64 ++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 247 +++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi.c                        |   1 +
 drivers/clk/sunxi/clk-sunxi.c                      |   6 +
 5 files changed, 319 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a83t.dtsi

-- 
1.9.1
