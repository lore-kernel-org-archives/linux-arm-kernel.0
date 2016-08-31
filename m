From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 31 Aug 2016 17:25:16 +0900
Subject: [PATCH v2 0/4] Add PWM feature in Allwinner H3
Message-ID: <20160831082520.25962-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the latest datasheet, H3 has single PWM channel.
H3 PWM controller has same register layout as sun4i driver, so it works 
by adding H3 specific data.
And the second PWM channel is not supported, so the pinctrl function is removed.

Datasheet:
  http://linux-sunxi.org/File:Allwinner_H3_Datasheet_V1.2.pdf

Test environment:
  Tested on Nano Pi M1 board, but PA5 pin is assigned for UART0.
  So the debug console should be changed to other port like UART1.

  Ex)
	aliases {
		serial0 = &uart1;
	};

	&uart1 {
        	pinctrl-names = "default";
	        pinctrl-0 = <&uart1_pins_a>;
        	status = "okay";
	};

v2:
  Split v1 patch-set into several patches

Milo Kim (4):
  ARM: dts: sun8i: Add PWM pin in H3
  ARM: dts: sun8i: Add PWM controller node in H3
  pinctrl: sunxi: Remove unsupported PWM channel pinmux in H3
  pwm: sunxi: Add H3 support

 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt |  1 +
 arch/arm/boot/dts/sun8i-h3.dtsi                     | 15 +++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c            |  1 -
 drivers/pwm/pwm-sun4i.c                             |  9 +++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.9.3
