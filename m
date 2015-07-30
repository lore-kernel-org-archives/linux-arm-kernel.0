From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 Jul 2015 19:00:57 +0200
Subject: [GIT PULL] at91: dt for 4.3 #1
Message-ID: <1438275657-10769-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the first batch of DT changes for 4.3. The main part of it is the
addition of a new SoC in the sama5 family: the sama5d2. Here is its product
.dtsi and the associated sama5d2 Xplained board description.
I'll send the little C code part of it in another pull-request or as a single
separated patch as I don't have other material on the "at91-4.3-soc" branch for
now...

Thanks, best regards,

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt

for you to fetch changes up to 22b5a0f7bc07ac4b4e4aab9a7f8cf2521819c1c4:

  ARM: at91/dt: add minimal sama5d2 Xplained board (2015-07-30 18:44:44 +0200)

----------------------------------------------------------------
First batch of DT changes for 4.3:
- some fixes on sama5d4 ADC definition
- adding Image Sensor Interface (aka ISI) on at91sam9m10g45ek board
- update rst controller compatible string on sama5 machines
- new sama5d2 DT definition and its reference board:
  the sama5d2 Xplained. Minimal configuration for now.

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: at91/dt: sama5d4: fix external trigger property
      ARM: at91/dt: sama5d4: move ADC pinctrl to board device trees

Josh Wu (2):
      ARM: at91/dt: add isi & ov2640 dt nodes for at91sam9m10g45ek board
      ARM: at91/dt: sama5: update rstc to correct compatible string

Ludovic Desroches (1):
      ARM: at91/dt: add basic dtsi for sama5d2 SoC

Nicolas Ferre (1):
      ARM: at91/dt: add minimal sama5d2 Xplained board

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 134 ++++
 arch/arm/boot/dts/at91-sama5d4_xplained.dts |   9 +
 arch/arm/boot/dts/at91-sama5d4ek.dts        |   9 +
 arch/arm/boot/dts/at91sam9g45.dtsi          |  48 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |  47 ++
 arch/arm/boot/dts/sama5d2.dtsi              | 925 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d3.dtsi              |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi              |  13 +-
 9 files changed, 1157 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_xplained.dts
 create mode 100644 arch/arm/boot/dts/sama5d2.dtsi

-- 
Nicolas Ferre
