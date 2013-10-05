From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  5 Oct 2013 16:39:16 +0200
Subject: [PATCH 0/4] Add support for the Allwinner A31 Reset Controllers
Message-ID: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset adds support for the reset controllers found in the Allwinner A31
SoCs. Since these controllers are pretty simple, basically just a few MMIO
registers, with a single bit controlling the reset state of the other devices
it asserts in reset, the driver is quite simple as well.

However, one of the IPs asserted in reset by these controllers are the timers,
the only thing standing out is that it requires to be registered before the
timers are initialized.

Thanks,
Maxime

Maxime Ripard (4):
  reset: Add Allwinner A31 Reset Controller Driver
  ARM: sunxi: Select ARCH_HAS_RESET_CONTROLLER
  ARM: sunxi: Register the A31 reset IP in init_time
  ARM: sun6i: Add the reset controller to the DTSI

 arch/arm/boot/dts/sun6i-a31.dtsi |  24 +++++++++
 arch/arm/mach-sunxi/Kconfig      |   1 +
 arch/arm/mach-sunxi/sunxi.c      |  22 ++++++++-
 drivers/reset/Makefile           |   1 +
 drivers/reset/reset-sun6i.c      | 102 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 drivers/reset/reset-sun6i.c

-- 
1.8.4
