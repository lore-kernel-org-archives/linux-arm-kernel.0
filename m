From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Thu, 28 Aug 2014 08:59:18 +0800
Subject: [PATCH v3 0/4] Rockchip soc theamal driver
Message-ID: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Changes in v3:(add dts configure)
        * address comments from Dmitry Torokhov and Arnd Bergmann:
        - fix clock-names in rockchip-thermal.txt
        - remove rockchip_thermal_control() in rockchip_set_mode()
        - fix some code style.
        - add dts configure.

Changes in v2:
        * address comments from Heiko Stubner:
        - fix dt-bindings in rockchip-thermal.txt
        - remove Author mark
        - rename TSADC_XXX->TSADCV2_XXX,it eill ready to merge compatible other SoCs.
        - fix a identation
        - remove clk_set_rate(),it's no necessary.
        - fix the SIMPLE_DEV_PM_OPS() function  style.

Tested On rk3288 SDK board.

Caesar Wang (4):
  thermal: rockchip: add driver for thermal
  dt-bindings: document Rockchip thermal
  ARM: dts: add main Thermal info to rk3288
  ARM: dts: enable Thermal on rk3288-evb board

 .../bindings/thermal/rockchip-thermal.txt          |  20 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   7 +
 arch/arm/boot/dts/rk3288.dtsi                      |  18 +
 drivers/thermal/Kconfig                            |   9 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/rockchip_thermal.c                 | 669 +++++++++++++++++++++
 6 files changed, 724 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 drivers/thermal/rockchip_thermal.c

-- 
1.9.1
