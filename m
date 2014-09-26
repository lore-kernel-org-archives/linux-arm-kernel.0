From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Fri, 26 Sep 2014 22:33:09 +0800
Subject: [PATCH v6 0/3] Rockchip soc thermal driver
Message-ID: <1411741992-18890-1-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v6:
        * address comments from Tomeu Vizoso.
        - use thermal's generic framework.

Changes in v5:
        * address comments from Eduardo Valentin,rui.zhang and Heiko Stubner:
        - with BIT() macro
        - manage clocks in suspend/resume.
	- license is fixed as GPLv2 .
	- #include "thermal_core.h"->#include <linux/thermal.h>
	- use the generic trip-points.the hw-shut-temp isn't generic trip-points.
	- The method of binding and unbinding be fixed.
	- The pin-name tsadc->otp_out

Changes in v4:
        * address comments from Jonathan Cameron,huangtao and zhaoyifeng:
        - this series thermal driver still be put in driver/thermal/
        - modify the thermal driver description.

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

Tested on rk3288 SDK board and pinky-v1 board.

Caesar Wang (3):
  thermal: rockchip: add driver for Thermal
  dt-bindings: document Rockchip thermal
  ARM: dts: add main Thermal info to rk3288

 .../bindings/thermal/rockchip-thermal.txt          |  32 ++
 arch/arm/boot/dts/rk3288.dtsi                      |  44 ++
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/rockchip_thermal.c                 | 605 +++++++++++++++++++++
 5 files changed, 692 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 drivers/thermal/rockchip_thermal.c

-- 
1.9.1
