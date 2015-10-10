From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 10 Oct 2015 23:12:30 +0200
Subject: [GIT PULL] LPC18xx DTS changes for v4.4
Message-ID: <1444511551-23853-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc team,

Please consider pulling these DTS changes for the NXP LPC18xx
platform and related boards into arm-soc/dt.

Contain DTS additions for drivers that went upstream during the
previous merge cycle and some board updates.

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://github.com/manabian/linux-lpc.git tags/lpc18xx_dts_for_4.4

for you to fetch changes up to 6031d8bbf29e7bdb22d69dc4dd7b2ad7a402e57a:

  ARM: dts: lpc4350-hitex-eval: add joystick, buttons and leds (2015-09-30 22:49:03 +0200)

----------------------------------------------------------------
Device Tree additions for NXP LPC18xx platform
 - Reset controller (RGU)
 - DMA controller and mux
 - SPI Flash (SPIFI) controller
 - I2C controller
 - Watchdog and SCT PWM from Ariel D'Alessandro

And board updates for EA4357 dev kit and Hitex LPC4350 eval board
adding I2C, SPIFI Flash and some miscellaneous stuff.

----------------------------------------------------------------
Ariel D'Alessandro (3):
      ARM: dts: lpc18xx: add watchdog node
      ARM: dts: lpc18xx: add sct pwm node
      ARM: dts: lpc4350-hitex-eval: add i2c0 and devices

Joachim Eastwood (13):
      ARM: dts: lpc18xx: add rgu node
      ARM: dts: lpc18xx: add spifi node
      ARM: dts: lpc18xx: add dmac node
      ARM: dts: lpc18xx: add dmamux node
      ARM: dts: lpc18xx: add dma to ssp0/1
      ARM: dts: lpc18xx: add dma to uart0/1/2/3
      ARM: dts: lpc18xx: add i2c nodes
      ARM: dts: lpc18xx: add resets entry to device nodes
      ARM: dts: lpc4357-ea4357: add spifi and flash device
      ARM: dts: lpc4357-ea4357: add ssp0
      ARM: dts: lpc4357-ea4357: add i2c0 and devices
      ARM: dts: lpc4350-hitex-eval: add spifi and flash device
      ARM: dts: lpc4350-hitex-eval: add joystick, buttons and leds

 arch/arm/boot/dts/lpc18xx.dtsi              | 134 +++++++++++++++++++++
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    | 175 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts |  95 +++++++++++++++
 3 files changed, 404 insertions(+)
