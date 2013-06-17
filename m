From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 18 Jun 2013 00:43:11 +0200
Subject: [PATCH 0/4] ARM: rockchip: add smp functionality
Message-ID: <201306180043.11785.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables the use of the additional cores on Rockchip
Cortex-A9 SoCs.

To achieve this, add the scu, the needed sram and power-management-unit.

This is again new teritory for me, so I might've messed up something,
but overall I'm happy to have gained a bit of smp understanding :-)

This of course goes on top of the basic support series.

Heiko Stuebner (4):
  arm: rockchip: add snoop-control-unit
  arm: rockchip: add sram dt nodes and documentation
  arm: rockchip: add power-management-unit dt node
  arm: rockchip: add smp bringup code

 .../devicetree/bindings/arm/rockchip/pmu.txt       |   16 +++
 .../devicetree/bindings/arm/rockchip/smp-sram.txt  |   29 ++++
 arch/arm/boot/dts/rk3066a.dtsi                     |   24 ++++
 arch/arm/mach-rockchip/Kconfig                     |    1 +
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/core.h                      |   22 +++
 arch/arm/mach-rockchip/headsmp.S                   |   32 +++++
 arch/arm/mach-rockchip/platsmp.c                   |  145 ++++++++++++++++++++
 arch/arm/mach-rockchip/rockchip.c                  |    2 +
 9 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
 create mode 100644 arch/arm/mach-rockchip/core.h
 create mode 100644 arch/arm/mach-rockchip/headsmp.S
 create mode 100644 arch/arm/mach-rockchip/platsmp.c

-- 
1.7.10.4
