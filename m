From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Sep 2014 00:34:28 +0200
Subject: [PATCH 0/3] ARM: rockchip: add cpuclk handling - arm-soc part
Message-ID: <1410561271-19197-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series provides the devicetree integration of the cpuclk provider
submitted against the clk-next tree.

It adds the necessary operating points and voltages as well as the
cpu regulator reference and a platform-device for cpufreq-cpu0

It needs an exported branch from the clock-tree that provides the
new ARMCLK id introduced there.


Heiko Stuebner (3):
  ARM: dts: rockchip: add operating points and armclk references
  ARM: dts: rockchip: add cpu supplies to boards
  ARM: rockchip: add a cpufreq-cpu0 device

 arch/arm/boot/dts/rk3066a-bqcurie2.dts |  4 ++++
 arch/arm/boot/dts/rk3066a.dtsi         | 12 +++++++++++-
 arch/arm/boot/dts/rk3188-radxarock.dts |  6 +++++-
 arch/arm/boot/dts/rk3188.dtsi          | 15 ++++++++++++++-
 arch/arm/boot/dts/rk3288-evb-rk808.dts |  6 +++++-
 arch/arm/boot/dts/rk3288.dtsi          | 19 ++++++++++++++++++-
 arch/arm/mach-rockchip/rockchip.c      |  7 +++++++
 7 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.0.1
