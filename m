From: k@japko.eu (Krzysztof Adamski)
Date: Mon, 22 Feb 2016 14:03:24 +0100
Subject: [PATCH v5 0/4] pinctrl: sunxi: Add H3 R_PIO controller support
Message-ID: <1456146208-13890-1-git-send-email-k@japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is extension of my original single patch with the same
subject. It adds support for R_PIO so that GPIO port L can be used in H3
based devices. It was tested on OrangePi PC and OrangePi Plus where PL
is connected amount others to an onboard led, a switch, an IR receiver
and some VCC controllers.

Patchset is based on next-20160222.

--- 

Changes since v4:
- remove patches that are alredy merged
- add patch describing leds and switch in DT

Changes since v3:
- collect some acked-bys
- fix r_pios #interrupt-cells

Changes since v2:
- fixed apb0 parrent clocks list
- moved binding documentation change to the proper patch
- simplified sunxi_pinctrl_gpio_get according to ChenYu suggestions
- fixed ordering in sunxi binding documentation

Changes since v1:
- splited patch to two separate - dtsi and c files
- added APB0 clocks a parent for R_PIO
- added fix in sunxi_pinctrl_gpio_get for getting pin value when in irq
  mode and on 2nd pinctrl
- fixed a "pwn" > "pwm" typo
- fixed order in allwinner,sunxi-pinctrl.txt


Krzysztof Adamski (4):
  clk: sunxi: Add apb0 gates for H3
  dts: sun8i-h3: Add APB0 related clocks and resets
  ARM: dts: sun8i-h3: Add R_PIO controller node to the dtsi
  ARM: dts: sun8i: Add leds and switch on Orangepi Plus boards

Krzysztof Adamski (4):
  clk: sunxi: Add apb0 gates for H3
  dts: sun8i-h3: Add APB0 related clocks and resets
  ARM: dts: sun8i-h3: Add R_PIO controller node to the dtsi
  ARM: dts: sun8i: Add leds and switch on Orangepi Plus boards

 Documentation/devicetree/bindings/clock/sunxi.txt |  2 +
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts      | 63 +++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                   | 37 +++++++++++++
 drivers/clk/sunxi/clk-simple-gates.c              |  4 ++
 4 files changed, 106 insertions(+)

-- 
2.1.4
