From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed, 31 Aug 2016 21:30:51 +0200
Subject: [PATCH v2 0/7] dts: sun8i: add extra uart/i2c to H3
Message-ID: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

This is v2 of my patch series. Just after sending I noticed the interrupts
of i2c1 were too liberally copy/paste'd. This is fixed in v2.

This series is a follow-up to Martin Ayotte's efforts to add additional UARTS
and I2C ports to the AllWinner H3 SoC DTS files. In this series I explicitly
leave out i2c2, since this is not broken out on my boards, so I cannot verify if
it actually works.

After the patch, one enables for example uart1 on a opi+ like this from u-boot:
 => fdt set /soc/serial at 01c28400 status okay

Regards,
Jorik

Jorik Jonker (7):
  dts: sun8i-h3: add pinmux definitions for uart2/uart3
  dts: sun8i-h3: add pinmux definitions for i2c0/i2c1
  dts: sun8i-h3: add i2c0/i2c1 SoC peripherals
  dts: sun8i-h3: add UART1-3 to Orange Pi Plus
  dts: sun8i-h3: add UART1-3 to Orange Pi PC
  dts: sun8i-h3: add I2C0-1 to Orange Pi Plus
  dts: sun8i-h3: add I2C0-1 to Orange Pi PC

 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts   | 25 ++++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 25 ++++++++++++++
 arch/arm/boot/dts/sun8i-h3.dtsi              | 50 ++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

-- 
2.7.4
