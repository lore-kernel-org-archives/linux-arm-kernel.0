From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 11 Sep 2017 04:22:37 +0200
Subject: [PATCH 0/4] arm64: Add initial Actions Semi S700 and CubieBoard7
 support
Message-ID: <20170911022241.11603-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series prepares the Actions Semi S700 SoC and Cubietech CubieBoard7.
It boots equally far as the S900 based Bubblegum-96 these patches are based on,
i.e. into an initrd with serial and all four cores up.

I have not yet managed to download the CubieBoard7 sources from Baidu, and the
Mega download has not yet been fixed, so this is based on the S700 datasheet
and /proc/device-tree/ from the preinstalled Android.

Lacking sources and instructions to replace the bootloader on eMMC or to try
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

Cc: Ahha Lee <lee@cubietech.com>
Cc: support at cubietech.com

Cc: devicetree at vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

Andreas F?rber (4):
  dt-bindings: arm: actions: Add S700 and CubieBoard7
  dt-bindings: timer: Add Actions Semi S700
  clocksource: owl: Prepare S700
  arm64: dts: actions: Add S700 and CubieBoard7

 Documentation/devicetree/bindings/arm/actions.txt  |  15 ++
 .../bindings/timer/actions,owl-timer.txt           |   1 +
 arch/arm64/boot/dts/actions/Makefile               |   2 +
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |  47 ++++++
 arch/arm64/boot/dts/actions/s700.dtsi              | 164 +++++++++++++++++++++
 drivers/clocksource/owl-timer.c                    |   1 +
 6 files changed, 230 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/s700-cubieboard7.dts
 create mode 100644 arch/arm64/boot/dts/actions/s700.dtsi

-- 
2.13.5
