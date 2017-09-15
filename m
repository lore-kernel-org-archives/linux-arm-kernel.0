From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 10:33:48 +0200
Subject: [PATCH 0/9] ARM: rockchip: add power-domains for Cortex-A9 socs
Message-ID: <20170915083357.11296-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A small bit of cleanup for some clocks nobody used yet but that
need to be toggled for the synchronous reset done on power-domain
state changes.

Domain values are done by the book (aka soc documentation for pmu
and power-domain <-> ip block connections) and tested with the gpu
and the wip lima kernel driver on rk3188.

Heiko Stuebner (9):
  clk: rockchip: add more rk3188 graphics clock ids
  clk: rockchip: use new cif/vdpu clock ids on rk3188
  dt-bindings: add power-domain header for RK3188 SoCs
  dt-bindings: add power-domain header for RK3066 SoCs
  dt-bindings: add compatibles for rk3066/rk3188 power controllers
  soc: rockchip: power-domain: add rk3188 powerdomains
  soc: rockchip: power-domain: add rk3066 powerdomains
  ARM: dts: rockchip: add qos nodes found on rk3066 and rk3188
  ARM: dts: rockchip: add rk3066/rk3188 power-domains

 .../bindings/soc/rockchip/power_domain.txt         |  4 ++
 arch/arm/boot/dts/rk3066a.dtsi                     | 51 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi                      | 48 ++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi                      | 40 +++++++++++++++++
 drivers/clk/rockchip/clk-rk3188.c                  | 12 ++---
 drivers/soc/rockchip/pm_domains.c                  | 48 ++++++++++++++++++++
 include/dt-bindings/clock/rk3188-cru-common.h      |  9 +++-
 include/dt-bindings/power/rk3066-power.h           | 21 +++++++++
 include/dt-bindings/power/rk3188-power.h           | 23 ++++++++++
 9 files changed, 248 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/power/rk3066-power.h
 create mode 100644 include/dt-bindings/power/rk3188-power.h

-- 
2.14.1
