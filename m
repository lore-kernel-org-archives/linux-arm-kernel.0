From: zyw@rock-chips.com (zyw at rock-chips.com)
Date: Wed, 15 Oct 2014 13:46:27 -0700
Subject: [PATCH 0/4] add suspend support for RK3288
Message-ID: <1413405987-16196-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Zhong <zyw@rock-chips.com>

this is the 1st version of suspend. RK3288 can shut down the cpu, gpu and
other device controllers in suspend, and it will pull the GLOBAL_PWROFF pin
to high in the final stage of the process of suspend, pull the pin to low again
when resume.


Chris Zhong (4):
  ARM: rockchip: add suspend and resume for RK3288
  clk: rockchip: RK3288: add suspend and resume
  ARM: dts: add RK3288 suspend support
  ARM: rockchip: add pmu-sram sub

 .../devicetree/bindings/arm/rockchip/pmu-sram.txt  |   15 +
 arch/arm/boot/dts/rk3288.dtsi                      |   11 +
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/pm.c                        |  292 ++++++++++++++++++++
 arch/arm/mach-rockchip/pm.h                        |  102 +++++++
 arch/arm/mach-rockchip/rockchip.c                  |   11 +-
 arch/arm/mach-rockchip/sleep.S                     |   87 ++++++
 drivers/clk/rockchip/clk-rk3288.c                  |   61 ++++
 8 files changed, 578 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt
 create mode 100644 arch/arm/mach-rockchip/pm.c
 create mode 100644 arch/arm/mach-rockchip/pm.h
 create mode 100644 arch/arm/mach-rockchip/sleep.S

-- 
1.7.9.5
