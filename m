From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 31 Dec 2017 16:11:27 +0100
Subject: [GIT PULL] ARM: at91: DT for 4.16
Message-ID: <20171231151127.GA19853@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is the at91 DT pull request. The bulk of it is the switch to the
new TCB bindings that were acked a long time ago. These changes are
compatible with the current driver and taking them now will allow for a
smooth transition.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.16-dt

for you to fetch changes up to 34a7fc3147bcc14127d941f228ce3b1737e66381:

  ARM: dts: at91: sama5d2_ptc_ek: use TCB0 as timers (2017-12-31 15:50:20 +0100)

----------------------------------------------------------------
DT for 4.16

 - New boards:
   - Axentia Nattis with Natte power
   - sama5d2 PTC ek
 - Document and use extended TCB bindings

----------------------------------------------------------------
Alexandre Belloni (45):
      ARM: at91: Document new TCB bindings
      ARM: dts: at91: at91rm9200: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: at91rm9200ek: use TCB0 for timers
      ARM: dts: at91: mpa1600: use TCB0 as timers
      ARM: dts: at91: at91sam9260: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: at91sam9260ek: use TCB0 as timers
      ARM: dts: at91: sam9_l9260: use TCB0 as timers
      ARM: dts: at91: ethernut5: use TCB0 as timers
      ARM: dts: at91: foxg20: use TCB0 as timers
      ARM: dts: at91: animeo_ip: use TCB0 as timers
      ARM: dts: at91: kizbox: use TCB0 as timers
      ARM: dts: at91: at91sam9g20ek: use TCB0 as timers
      ARM: dts: at91: ge863-pro3: use TCB0 as timers
      ARM: dts: at91: at91sam9261: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: at91sam9261ek: use TCB0 as timers
      ARM: dts: at91: at91sam9263: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: at91sam9263ek: use TCB0 as timers
      ARM: dts: at91: calao: use TCB0 as timers
      ARM: dts: at91: at91sam9g45: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: at91sam9m10g45ek: use TCB0 as timers
      ARM: dts: at91: pm9g45: use TCB0 as timers
      ARM: dts: at91: at91sam9rl: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: at91sam9rlek: use TCB0 as timers
      ARM: dts: at91: at91sam9n12: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: at91sam9n12ek: use TCB0 as timers
      ARM: dts: at91: at91sam9x5: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: at91sam9x5cm: use TCB0 as timers
      ARM: dts: at91: acme/g25: use TCB0 as timers
      ARM: dts: at91: cosino: use TCB0 as timers
      ARM: dts: at91: kizboxmini: use TCB0 as timers
      ARM: dts: at91: sama5d3: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: sama5d3xek: use TCB0 as timers
      ARM: dts: at91: sama5d3 Xplained: use TCB0 as timers
      ARM: dts: at91: kizbox2: use TCB0 as timers
      ARM: dts: at91: sama5d3xek_cmp: use TCB0 as timers
      ARM: dts: at91: linea/tse850-3: use TCB0 as timers
      ARM: dts: at91: sama5d4: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: sama5d4: Add TCB2
      ARM: dts: at91: sama5d4ek: use TCB2 as timers
      ARM: dts: at91: sama5d4 Xplained: use TCB2 as timers
      ARM: dts: at91: ma5d4: use TCB2 as timers
      ARM: dts: at91: vinco: use TCB2 as timers
      ARM: dts: at91: sama5d2: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: sama5d2 Xplained: use TCB0 as timers
      ARM: dts: at91: sama5d27_som1_ek: use TCB0 as timers

Eugen Hristev (1):
      ARM: dts: at91: sama5d2: added dma property for ADC device

Ludovic Desroches (1):
      ARM: dts: at91: introduce the sama5d2 ptc ek board

Mathieu Malaterre (1):
      ARM: dts: at91: Remove leading 0x and 0s from bindings notation

Nicolas Ferre (1):
      ARM: dts: at91: sama5d2_ptc_ek: use TCB0 as timers

Peter Rosin (1):
      ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power

 .../devicetree/bindings/arm/atmel-at91.txt         |  32 --
 Documentation/devicetree/bindings/arm/axentia.txt  |   9 +
 .../devicetree/bindings/mfd/atmel-tcb.txt          |  56 +++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/animeo_ip.dts                    |  12 +
 arch/arm/boot/dts/at91-ariag25.dts                 |  12 +
 arch/arm/boot/dts/at91-ariettag25.dts              |  12 +
 arch/arm/boot/dts/at91-cosino.dtsi                 |  12 +
 arch/arm/boot/dts/at91-foxg20.dts                  |  12 +
 arch/arm/boot/dts/at91-kizbox.dts                  |  12 +
 arch/arm/boot/dts/at91-kizbox2.dts                 |  12 +
 arch/arm/boot/dts/at91-kizboxmini.dts              |  12 +
 arch/arm/boot/dts/at91-linea.dtsi                  |  12 +
 arch/arm/boot/dts/at91-natte.dtsi                  | 244 ++++++++++++
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts        | 258 +++++++++++++
 arch/arm/boot/dts/at91-qil_a9260.dts               |  12 +
 arch/arm/boot/dts/at91-sam9_l9260.dts              |  12 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          | 413 +++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |  12 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d4ek.dts               |  12 +
 arch/arm/boot/dts/at91-vinco.dts                   |  12 +
 arch/arm/boot/dts/at91rm9200.dtsi                  |   8 +-
 arch/arm/boot/dts/at91rm9200ek.dts                 |  12 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |   8 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |  12 +
 arch/arm/boot/dts/at91sam9261.dtsi                 |   6 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |  22 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   6 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |  14 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |  12 +
 arch/arm/boot/dts/at91sam9g25ek.dts                |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  10 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |  14 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   8 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |  12 +
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   4 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |  12 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   8 +-
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |  12 +
 arch/arm/boot/dts/ethernut5.dts                    |  12 +
 arch/arm/boot/dts/ge863-pro3.dtsi                  |  12 +
 arch/arm/boot/dts/mpa1600.dts                      |  12 +
 arch/arm/boot/dts/pm9g45.dts                       |  12 +
 arch/arm/boot/dts/sama5d2.dtsi                     |  10 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   4 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi                |   4 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi                  |  12 +
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi              |  12 +
 arch/arm/boot/dts/sama5d3xmb.dtsi                  |   2 +-
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi              |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |  18 +-
 arch/arm/boot/dts/tny_a9260_common.dtsi            |  12 +
 arch/arm/boot/dts/tny_a9263.dts                    |  12 +
 arch/arm/boot/dts/usb_a9260_common.dtsi            |  12 +
 arch/arm/boot/dts/usb_a9263.dts                    |  12 +
 60 files changed, 1514 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644 arch/arm/boot/dts/at91-natte.dtsi
 create mode 100644 arch/arm/boot/dts/at91-nattis-2-natte-2.dts
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
