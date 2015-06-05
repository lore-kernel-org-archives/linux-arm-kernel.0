From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 5 Jun 2015 15:00:18 +0200
Subject: [GIT PULL] at91: dt for 4.2 #4
Message-ID: <1433509218-21690-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Another batch of DT changes for 4.2. The bulk of it is the move to stdout-path
for our cosonle.
As usual, the material is based on previous at91-dt3 that you already have.

Thanks, best regards,

The following changes since commit f80737082c210fae8ce15ad5d615da381889d5e9:

  ARM: at91/dt: remove useless usb clock (2015-05-22 11:11:33 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt4

for you to fetch changes up to ea25525ce0d195724fead07fe6562fe478a3bf6f:

  ARM: at91/dt: sama5d4ek: mci0 uses slot 0 (2015-06-04 11:49:12 +0200)

----------------------------------------------------------------
Fourth batch of DT changes for 4.2:
- rtc node for at91sam9rl/at91sam9rlek
- move to stdout-path for console on kizbox and all Atmel's boards
- Addition of the Acme Systems' Arietta G25
- two little fixes for Kizbox and sama5d4ek

----------------------------------------------------------------
Alexandre Belloni (16):
      ARM: at91/dt: at91sam9rl: fix rtc node
      ARM: at91/dt: at91sam9rlek: add RTC
      ARM: at91/dt: kizbox: use stdout-path
      ARM: at91/dt: at91rm9200ek: use stdout-path
      ARM: at91/dt: at91sam9261ek: use stdout-path
      ARM: at91/dt: at91sam9263ek: use stdout-path
      ARM: at91/dt: at91sam9g20ek: use stdout-path
      ARM: at91/dt: at91sam9m10g45ek use stdout-path
      ARM: at91/dt: at91sam9n12ek: use stdout-path
      ARM: at91/dt: at91sam9rlek: use stdout-path
      ARM: at91/dt: at91sam9x5ek: use stdout-path
      ARM: at91/dt: sama5d3xek: use stdout-path
      ARM: at91/dt: sama5d3 xplained: use stdout-path
      ARM: at91/dt: sama5d4ek: use stdout-path
      ARM: at91/dt: sama5d4 xplained: use stdout-path
      ARM: at91/dt: Add Acme Arietta G25

Ga?l PORTAY (1):
      ARM: at91/dt: kizbox: fix mismatch LED PWM device

Ludovic Desroches (1):
      ARM: at91/dt: sama5d4ek: mci0 uses slot 0

 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/at91-ariettag25.dts       | 79 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91-kizbox.dts           |  4 +-
 arch/arm/boot/dts/at91-kizbox2.dts          |  2 +-
 arch/arm/boot/dts/at91-kizboxmini.dts       |  2 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts |  2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts |  3 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts        |  7 +--
 arch/arm/boot/dts/at91rm9200ek.dts          |  4 ++
 arch/arm/boot/dts/at91sam9261ek.dts         |  3 +-
 arch/arm/boot/dts/at91sam9263ek.dts         |  3 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  3 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |  3 +-
 arch/arm/boot/dts/at91sam9n12ek.dts         |  3 +-
 arch/arm/boot/dts/at91sam9rl.dtsi           | 15 +++---
 arch/arm/boot/dts/at91sam9rlek.dts          |  7 ++-
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |  3 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi           |  3 +-
 18 files changed, 123 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-ariettag25.dts

-- 
Nicolas Ferre
