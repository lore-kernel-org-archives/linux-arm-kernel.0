From: yh.huang@mediatek.com (YH Huang)
Date: Mon, 6 Jul 2015 21:29:25 +0800
Subject: [PATCH v4 0/3] Add MediaTek display PWM driver
Message-ID: <1436189368-1826-1-git-send-email-yh.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add the use of display PWM driver, documentation 
and device tree for Mediatek SoCs. The driver is used to support 
the backlight of the panel. This is based on v4.2-rc1.

The clock definitions (CLK_MM_DISP_PWM*) are added by James Liao's patch: 
clk: mediatek: Add subsystem clocks of MT8173

Change in v4:
1. Codebase is on v4.2-rc1
2. Add the PWM node in dtsi 
3. Change the dependency in Kconfig
4. Rewrite some code for readability 

YH Huang (3):
  dt-bindings: pwm: add MediaTek display PWM bindings
  pwm: add MediaTek display PWM driver support
  arm64: dts: mt8173: add MT8173 display PWM driver support dtsi

 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  24 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  22 ++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-mtk-disp.c                         | 256 +++++++++++++++++++++
 5 files changed, 313 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
 create mode 100644 drivers/pwm/pwm-mtk-disp.c

--
1.8.1.1.dirty
