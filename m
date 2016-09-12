From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Mon, 12 Sep 2016 20:12:42 +0200
Subject: [PATCH v5 0/5] dts: sun8i-h3: complete UART I2C for H3
Message-ID: <1473703967-21356-1-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

This is my fifth attempt to complete the UART/I2C definitions on H3.

Many thanks to Maxime and Chen-Yu for helping me understand the 
philosophy behind the DTS/DTSI structure. I hope I get it and five
times is a charm :-)

Changes since v4:
 * RTS/CTS for UART1 is split off in seperate pinmux to make uart1-3
   consistent.
 * UART0 is left untouched
 * UARTs 1-3 are associated and re-disabled in DTS instead of DTSI

Best,
Jorik

Jorik Jonker (5):
  dts: sun8i-h3: add pinmux definitions for UART2-3
  dts: sun8i-h3: split off RTS/CTS for UART1 in seperate pinmux
  dts: sun8i-h3: associate exposed UARTs on Orange Pi Boards
  dts: sun8i-h3: add pinmux definitions for I2C0-2
  dts: sun8i-h3: add I2C0-2 peripherals to H3 SOC

 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts |  2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts       | 18 ++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts     | 18 ++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts      | 18 ++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                 | 85 ++++++++++++++++++++++++-
 5 files changed, 138 insertions(+), 3 deletions(-)

-- 
2.7.4
