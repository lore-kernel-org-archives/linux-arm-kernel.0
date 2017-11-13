From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 00:34:19 +0100
Subject: [PATCH v2 0/8] arm64: Add initial Actions Semi S700 and CubieBoard7
 support
Message-ID: <20171113233427.5386-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series prepares the Actions Semi S700 SoC and Cubietech CubieBoard7.
It boots equally far as the S900 based Bubblegum-96 these patches are based on,
i.e. into an initrd with serial and all four cores up.

v2 modifies the clocksource driver patches and adds SPS patches.

Not having succeeded to replace the bootloader on eMMC or to try
booting from SD, the only working way I've found to boot mainline kernels
appears to be booting into Android, then issuing "reboot bootloader". U-Boot
is lacking the saveenv command, so it wasn't possible to change the bootdelay
to facilitate this.

Cf. https://en.opensuse.org/HCL:CubieBoard7

Work branch:
https://github.com/afaerber/linux/commits/bg96-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* Prepended patch converting CLOCKSOURCE_OF_DECLARE() to TIMER_OF_DECLARE() (Daniel)
* Added patches for SPS

Cc: Ahha Lee <lee@cubietech.com>
Cc: support at cubietech.com
Cc: Jeff Chen <jeff.chen@actions-semi.com>

Cc: devicetree at vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

Andreas F?rber (8):
  dt-bindings: arm: actions: Add S700 and CubieBoard7
  dt-bindings: timer: Add Actions Semi S700
  clocksource: owl: Adopt TIMER_OF_DECLARE()
  clocksource: owl: Prepare S700
  arm64: dts: actions: Add S700 and CubieBoard7
  dt-bindings: power: Add Actions Semi S700 SPS
  soc: actions: sps: Add S700
  arm64: dts: actions: Add S700 SPS node

 Documentation/devicetree/bindings/arm/actions.txt  |  15 ++
 .../devicetree/bindings/power/actions,owl-sps.txt  |   2 +
 .../bindings/timer/actions,owl-timer.txt           |   1 +
 arch/arm64/boot/dts/actions/Makefile               |   2 +
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |  47 ++++++
 arch/arm64/boot/dts/actions/s700.dtsi              | 170 +++++++++++++++++++++
 drivers/clocksource/owl-timer.c                    |   5 +-
 drivers/soc/actions/owl-sps.c                      |  42 +++++
 include/dt-bindings/power/owl-s700-powergate.h     |  20 +++
 9 files changed, 302 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/actions/s700-cubieboard7.dts
 create mode 100644 arch/arm64/boot/dts/actions/s700.dtsi
 create mode 100644 include/dt-bindings/power/owl-s700-powergate.h

-- 
2.13.6
