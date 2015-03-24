From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 24 Mar 2015 16:55:00 +0200
Subject: [PATCHv2 00/10] ARM: DRA7: add display support
Message-ID: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds the arch/arm/ side of the display support for DRA7 (DRA72x,
DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM boards
is added.

This series is v2, and is based on Tero's "[PATCHv5 00/35] ARM: OMAP2+:
PRCM/SCM cleanups against 4.0-rc" series. The difference to v1 is that the
DESHDCP clock is a real clock, even if we still always enable it at boot time.

 Tomi

Tomi Valkeinen (10):
  arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
  ARM: DRA7: hwmod: add DMM hwmod description
  ARM: DRA7: hwmod: set DSS submodule parent hwmods
  ARM: OMAP: display: change compat names to array
  ARM: OMAP2+: display: detect DRA7 DSS
  arm/dts: dra7.dtsi: add DSS support
  arm/dts: dra72-evm.dts: add HDMI
  arm/dts: am57xx-beagle-x15.dts: add HDMI
  arm: dra7: add DESHDCP clock
  CLK: TI: always enable DESHDCP clock

 arch/arm/boot/dts/am57xx-beagle-x15.dts   |  81 ++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi               |  43 ++++++++++++
 arch/arm/boot/dts/dra72-evm.dts           | 110 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72x.dtsi             |  11 +++
 arch/arm/boot/dts/dra74x.dtsi             |  15 ++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi      |  11 +++
 arch/arm/mach-omap2/display.c             |  32 +++++----
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  33 +++++++++
 drivers/clk/ti/clk-7xx.c                  |   8 ++-
 9 files changed, 328 insertions(+), 16 deletions(-)

-- 
2.3.3
