From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 17 Nov 2015 12:35:58 +0100
Subject: [GIT PULL] at91: fixes for 4.4 #1
Message-ID: <1447760158-20204-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the first "fixes" pull-request for AT91. I tried to collect little
patches that didn't make it for -rc1.
It can be due to synchronization between trees like the addition of some
sama5d2 Xplained nodes (MFD tree) or the change of the watchdog compatible
string for sama5d4 (watchdog tree).
It can also be due to trivial cleanups that were spotted or submitted late like
the replacement of "wakeup" properties or removal of unneeded defconfig option.
The removal of some dead legacy DT properties or nodes is, in my opinion worth
it as well in order to prevent us from abusive cut'n paste.
NAND and ISI Atmel MAINTAINERS entries are also updated.

Tell me if it's okay for you.

Thanks, best regards,

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes

for you to fetch changes up to 50cb2efaa63bdfd4a68b94acc55a12e68d9c33d4:

  MAINTAINERS: Atmel drivers: change NAND and ISI entries (2015-11-17 12:08:46 +0100)

----------------------------------------------------------------
First fixes for 4.4:
- removal of a useless defconfig option
- removal of some legacy DT pieces
- use of the proper watchdog compatible string
- addition of some sama5d2 Xplained nodes now that the MFD include is in place
- update of the MAINTAINERS entries for some Atmel drivers

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: at91/dt: remove leftovers clock definition
      ARM: at91/dt: remove bootargs

Ludovic Desroches (1):
      ARM: at91/dt: sama5d2 Xplained: add several devices

Nicolas Ferre (2):
      ARM: at91/defconfig: remove CONFIG_SSB from Atmel defconfigs
      MAINTAINERS: Atmel drivers: change NAND and ISI entries

Sudeep Holla (1):
      ARM: at91/dt: replace gpio-key,wakeup with wakeup-source property

Wenyou Yang (1):
      ARM: at91/dt: sama5d4: change watchdog compatible

 MAINTAINERS                                 |   5 +-
 arch/arm/boot/dts/animeo_ip.dts             |   6 +-
 arch/arm/boot/dts/at91-foxg20.dts           |   2 +-
 arch/arm/boot/dts/at91-kizbox.dts           |  13 +---
 arch/arm/boot/dts/at91-kizbox2.dts          |   6 +-
 arch/arm/boot/dts/at91-kizboxmini.dts       |   4 +-
 arch/arm/boot/dts/at91-qil_a9260.dts        |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 115 +++++++++++++++++++++++++---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts |   2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts |  12 +--
 arch/arm/boot/dts/at91-sama5d4ek.dts        |  12 +--
 arch/arm/boot/dts/at91rm9200ek.dts          |   9 ---
 arch/arm/boot/dts/at91sam9261ek.dts         |  19 ++---
 arch/arm/boot/dts/at91sam9263ek.dts         |  13 +---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  13 +---
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |  13 +---
 arch/arm/boot/dts/at91sam9n12ek.dts         |  11 +--
 arch/arm/boot/dts/at91sam9rlek.dts          |  13 +---
 arch/arm/boot/dts/at91sam9x5cm.dtsi         |  11 ---
 arch/arm/boot/dts/sama5d35ek.dts            |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi              |   2 +-
 arch/arm/boot/dts/usb_a9260_common.dtsi     |   2 +-
 arch/arm/boot/dts/usb_a9263.dts             |   2 +-
 arch/arm/configs/at91_dt_defconfig          |   1 -
 arch/arm/configs/sama5_defconfig            |   1 -
 25 files changed, 142 insertions(+), 149 deletions(-)

-- 
Nicolas Ferre
