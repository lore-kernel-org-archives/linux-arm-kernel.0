From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 16 Dec 2013 20:09:53 +0100
Subject: [GIT PULL] Support for efm32
Message-ID: <20131216190953.GB14866@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/efm32

for you to fetch changes up to ef43eff3447f30b4a3cfc61813902c2e57c20245:

  ARM: device trees for Energy Micro's EFM32 Cortex-M3 SoCs (2013-12-16 17:51:34 +0100)

----------------------------------------------------------------
These two commits add preliminary support for Energy Micro (now Silicon Labs)
Giant Gecko SoCs. They have a Cortex-M3 core, and so are Thumb2 only and don't
feature an MMU. With these changes merged there is no additional code needed
under arch/arm to run Linux on such a SoC.
----------------------------------------------------------------

Compared to the patch sent a few days ago (v5, Message-Id:
1386694516-5876-1-git-send-email-u.kleine-koenig at pengutronix.de), I let
ARCH_EFM32 temporarily select CLKSRC_MMIO until 4ff3774 (clocksource:
time-efm32: Select CLKSRC_MMIO) hits mainline. Also I just noticed that
the clk support got in v3.13-rc1, so the device tree is buildable now.
This patch adding the device tree sources wasn't sent yet in it's
current form, so I will send it as reply to this mail. I hope it's not
controversal, so the two patches can go in together.

I choosed to base these changes on top of a more recent tree than
armsoc/next/soc currently is based on (v3.13-rc1 vs v3.13-rc4) because
to successfully build for ARM v7-M commit 5091333 (ARM: 7895/1: signal:
fix armv7-m build issue in sigreturn_codes.S) which is included in
v3.13-rc3 (but not earlier).

Uwe Kleine-K?nig (2):
      ARM: new platform for Energy Micro's EFM32 Cortex-M3 SoCs
      ARM: device trees for Energy Micro's EFM32 Cortex-M3 SoCs

 arch/arm/Kconfig                               |  22 +++-
 arch/arm/Makefile                              |   1 +
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/armv7-m.dtsi                 |  18 +++
 arch/arm/boot/dts/efm32gg-dk3750.dts           |  86 +++++++++++++
 arch/arm/boot/dts/efm32gg.dtsi                 | 172 +++++++++++++++++++++++++
 arch/arm/configs/efm32_defconfig               | 102 +++++++++++++++
 arch/arm/mach-efm32/Makefile                   |   1 +
 arch/arm/mach-efm32/Makefile.boot              |   3 +
 arch/arm/mach-efm32/dtmachine.c                |  15 +++
 arch/arm/mach-efm32/include/mach/entry-macro.S |   4 +
 arch/arm/mach-efm32/include/mach/timex.h       |   3 +
 12 files changed, 427 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/armv7-m.dtsi
 create mode 100644 arch/arm/boot/dts/efm32gg-dk3750.dts
 create mode 100644 arch/arm/boot/dts/efm32gg.dtsi
 create mode 100644 arch/arm/configs/efm32_defconfig
 create mode 100644 arch/arm/mach-efm32/Makefile
 create mode 100644 arch/arm/mach-efm32/Makefile.boot
 create mode 100644 arch/arm/mach-efm32/dtmachine.c
 create mode 100644 arch/arm/mach-efm32/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-efm32/include/mach/timex.h

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
