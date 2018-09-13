From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Sep 2018 22:29:15 +0200
Subject: [PATCH 0/4] Meson8b: Odroid-C1 improvements
Message-ID: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small collection of improvements for the Odroid-C1 board.
My main goal is to prepare the CPU voltage regulator as I'm using
the Odroid-C1 to test my changes which will enable CPU frequency
scaling on Meson8/Meson8b/Meson8m2.

While I was going through the schematics anyways I added more
regulators, enabled the SAR ADC and added the /chosen/stdout-path
property to make debugging with "earlycon" easier.

schematics for the board are published by Hardkernel and can be found
here: [0]

NOTE: This series depends on my patch "ARM: dts: meson8b: add the
I2C_A, PWM_C and UART_B pins" [1] from my other series called
"Meson8b: add support for the Endless Mini EC-100" as this defines
the "pwm_c1_pins" for the CPU voltage regulator (which is controlled
via PWM).


[0] https://dn.odroid.com/S805/Schematics/odroid-c1+_rev0.4_20150615.pdf
[1] https://patchwork.kernel.org/patch/10600043/
[2] https://patchwork.kernel.org/cover/10600031/

Martin Blumenstingl (4):
  ARM: dts: meson8b: odroidc1: add the CPU voltage regulator
  ARM: dts: meson8b: odroidc1: add the fixed voltage regulators
  ARM: dts: meson8b: odroidc1: enable the SAR ADC
  ARM: dts: meson8b: odroidc1: add stdout-path property

 arch/arm/boot/dts/meson8b-odroidc1.dts | 109 +++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

-- 
2.19.0
