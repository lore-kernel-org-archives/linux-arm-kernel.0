From: menschel.p@posteo.de (Patrick Menschel)
Date: Sun, 12 Mar 2017 14:28:09 +0100
Subject: [PATCH 0/2] ARM: dts: sunxi: Add CAN node and can0_pins_a pinctrl
 setting
Message-ID: <1489325291-6298-1-git-send-email-menschel.p@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10/A20 SoCs have an on-board CAN (Controller Area Network)
controller. This patch adds the CAN core to the SoC's include files,
sun4i-a10.dtsi and sun7i-a20.dtsi.

On linux-can mailing list was a discussion about updating the device tree bindings
https://lkml.org/lkml/2015/9/17/220
but it did not progress past writing the documentation file.
Documentation/devicetree/bindings/net/can/sun4i_can.txt

The CAN controller can be enabled in a board specific dts file as
described in the documentation file or by using a device tree overlay.

I have tested the patch on a Banana Pi (A20 SoC) with mainline kernel 4.9.13.

Patrick Menschel (2):
  ARM: dts: sun4i: Add CAN node and can0_pins_a pinctrl settings
  ARM: dts: sun7i: Add CAN node and can0_pins_a pinctrl settings

 arch/arm/boot/dts/sun4i-a10.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

-- 
1.9.1
