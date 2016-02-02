From: k@japko.eu (Krzysztof Adamski)
Date: Tue,  2 Feb 2016 22:21:48 +0100
Subject: [PATCH v2 0/5] pinctrl: sunxi: Add H3 R_PIO controller support
Message-ID: <1454448113-18810-1-git-send-email-k@japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is extension of my original single patch with the
same subject. It adds support for R_PIO so that GPIO port L can be
used in H3 based devices. It was tested on OrangePi PC where PL is
connected amount others to an onboard led, a switch and IR receiver and
some VCC controllers.

Patchset was based on next-20160129.

--- 

Changes since v1:
- splited patch to two separate - dtsi and c files
- added APB0 clocks a parent for R_PIO
- added fix in sunxi_pinctrl_gpio_get for getting pin value when in irq
  mode and on 2nd pinctrl
- fixed a "pwn" > "pwm" typo
- fixed order in allwinner,sunxi-pinctrl.txt


Krzysztof Adamski (5):
  clk: sunxi: Add apb0 gates for H3
  dts: sun8i-h3: Add APB0 related clocks and resets
  pinctrl: sunxi: Add H3 R_PIO controller support
  ARM: dts: sun8i-h3: Add R_PIO controller node to the dtsi
  pinctrl: sunxi: Use pin number when calling sunxi_pmx_set

 Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  44 +++++++++
 drivers/clk/sunxi/clk-simple-gates.c               |   2 +
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c         | 106 +++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   9 +-
 8 files changed, 165 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c

-- 
2.1.4
