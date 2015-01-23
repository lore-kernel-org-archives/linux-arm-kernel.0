From: balbi@ti.com (Felipe Balbi)
Date: Fri, 23 Jan 2015 17:11:40 -0600
Subject: [PATCH 0/4] arm: am43xx: add PMU support
Message-ID: <1422054704-14915-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

with these patches we can use perf with AM43xx devices
and get actual statistics.

Full boot logs: http://hastebin.com/yoxaxurohu

Felipe Balbi (4):
  arm: omap: hwmod: 43xx: add DebugSS hwmod data
  arm: dts: am4372: add missing debugss clocks
  clk: ti: 43xx: add debugss clocks to DT_CLK() table
  arm: dts: am4372: add pmu DT data

 arch/arm/boot/dts/am4372.dtsi              |  8 +++++
 arch/arm/boot/dts/am43xx-clocks.dtsi       | 51 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 40 +++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |  1 +
 drivers/clk/ti/clk-43xx.c                  |  6 ++++
 5 files changed, 106 insertions(+)

-- 
2.3.0-rc1
