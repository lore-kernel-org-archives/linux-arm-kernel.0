From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 22 May 2014 18:24:55 +0200
Subject: [GIT PULL] at91: DT for 3.16 at91-dt3 #3
Message-ID: <1400775895-31183-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Another AT91 DT pull-request for 3.16. This one is the conversion of two more
SoC to Common Clock Framework (aka CCF). I identified it as a "DT" pull-request
but it modifies slightly a couple of files in mach-at91 (use of a configuration
option).
This pull-request depends on:
- the fixes that I already sent for 3.15 and that are present in the recent
  3.15-rc6 tag.
- the at91-cleanup tag that you integrated in your arm-soc/next/soc branch.
So, as suggested by Arnd on IRC, I merged both of them to act as the base
before adding the material for this pull-request.

About the clock nodes that should be grouped in a "clocks" container or not,
while waiting for a clear statement by the DT maintainers, I kept the clocks
nodes as they had been written by Boris.
As proposed by Olof, I plan to send you a comprehensive patch that fixes this
when Mark gives his point of view.

Thanks, best regards,

The following changes since commit 6a84872a3c3090993be108f02f91b4de062a7d32:

  Merge branch 'at91-3.16-cleanup' into at91-3.16-dt3 (2014-05-22 18:01:22 +0200)

are available in the git repository at:


  git://github.com/at91linux/linux-at91.git tags/at91-dt3

for you to fetch changes up to b4a86b3810f5dc4b959ee69a3818c876752c88cd:

  ARM: at91: move sam9n12 SoC to the CCF (2014-05-22 18:03:17 +0200)

----------------------------------------------------------------
3.16 third DT series:
- move of both at91sam9n12 and at91sam9x5 to CCF

----------------------------------------------------------------
Boris BREZILLON (8):
      ARM: at91: prepare common clk transition for sam9x5 SoCs
      ARM: at91/dt: define sam9x5 clocks
      ARM: at91/dt: define sam9x5ek's crystal frequencies
      ARM: at91: move sam9x5 SoCs to the CCF
      ARM: at91: prepare common clk transition for sam9n12 SoC
      ARM: at91/dt: define sam9n12 clocks
      ARM: at91/dt: define sam9n12ek crystal frequencies
      ARM: at91: move sam9n12 SoC to the CCF

 arch/arm/boot/dts/at91sam9n12.dtsi       | 348 +++++++++++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9n12ek.dts      |   8 +
 arch/arm/boot/dts/at91sam9x5.dtsi        | 355 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9x5_can.dtsi    |  31 +++
 arch/arm/boot/dts/at91sam9x5_isi.dtsi    |  26 +++
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi    |  26 +++
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi  |  11 +
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi  |  11 +
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  11 +
 arch/arm/boot/dts/at91sam9x5cm.dtsi      |   8 +
 arch/arm/mach-at91/Kconfig               |   2 -
 arch/arm/mach-at91/at91sam9n12.c         |   6 +-
 arch/arm/mach-at91/at91sam9x5.c          |   6 +-
 13 files changed, 842 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9x5_can.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x5_isi.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x5_lcd.dtsi

-- 
Nicolas Ferre
