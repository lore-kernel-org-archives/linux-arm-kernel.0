From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 11 Apr 2014 16:04:03 +0800
Subject: [PATCH 0/4] ARM: imx6: cleanup for fixed-clock
Message-ID: <1397203447-22965-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series cleans up fixed-clock handling for imx6 a little bit, so that
we can have clock driver simply call of_clk_get_by_name() than
imx_obtain_fixed_clock() to retrieve the clocks, and generic name can
just be used for these clocks.

Shawn Guo (4):
  ARM: dts: imx: add required #clock-cells for fixed-clock
  ARM: dts: imx6: define input clocks to CCM block
  ARM: dts: imx6: use of_clk_get_by_name() to retrieve fixed-clock
  ARM: dts: imx6: use generic name for fixed-clock nodes

 arch/arm/boot/dts/imx25.dtsi      |  1 +
 arch/arm/boot/dts/imx27-apf27.dts |  1 +
 arch/arm/boot/dts/imx27.dtsi      |  1 +
 arch/arm/boot/dts/imx50.dtsi      |  4 ++++
 arch/arm/boot/dts/imx51.dtsi      |  4 ++++
 arch/arm/boot/dts/imx53.dtsi      |  4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi    | 23 +++++++++++++++++------
 arch/arm/boot/dts/imx6sl.dtsi     | 12 ++++++++++--
 arch/arm/boot/dts/vf610-twr.dts   |  2 ++
 arch/arm/boot/dts/vf610.dtsi      |  2 ++
 arch/arm/mach-imx/clk-imx6q.c     |  6 +++---
 arch/arm/mach-imx/clk-imx6sl.c    |  4 ++--
 12 files changed, 51 insertions(+), 13 deletions(-)

-- 
1.8.3.2
