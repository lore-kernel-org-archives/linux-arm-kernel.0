From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:24 +0100
Subject: [PATCH 00/45] Migrate TCB bindings
Message-ID: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As the bindings were acked by Rob a while ago [1] and I think there is
consensus on what they look like, I'm planning to apply that series for
4.16 so we get a smoother transition for the TCB driver rework.

I've simply removed the PWM binding change that I will submit with the
driver change itself.
There is also a small fix in the at91sam9261ek patch.

[1] https://patchwork.kernel.org/patch/9755341/

Cc: Antoine Aubert <a.aubert@overkiz.com>
Cc: devicetree at vger.kernel.org
Cc: Douglas Gilbert <dgilbert@interlog.com>
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Martin Reimann <martin.reimann@egnite.de>
Cc: Peter Rosin <peda@axentia.se>
Cc: Raashid Muhammed <raashidmuhammed@zilogic.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Rodolfo Giometti <giometti@linux.it>
Cc: Sergio Tanzilli <tanzilli@acmesystems.it>
Cc: Tim Schendekehl <tim.schendekehl@egnite.de>

Alexandre Belloni (45):
  ARM: at91: Document new TCB bindings
  ARM: dts: at91: at91rm9200: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91rm9200ek: use TCB0 for timers
  ARM: dts: at91: mpa1600: use TCB0 as timers
  ARM: dts: at91: at91sam9260: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9260ek: use TCB0 as timers
  ARM: dts: at91: sam9_l9260: use TCB0 as timers
  ARM: dts: at91: ethernut5: use TCB0 as timers
  ARM: dts: at91: foxg20: use TCB0 as timers
  ARM: dts: at91: animeo_ip: use TCB0 as timers
  ARM: dts: at91: kizbox: use TCB0 as timers
  ARM: dts: at91: at91sam9g20ek: use TCB0 as timers
  ARM: dts: at91: ge863-pro3: use TCB0 as timers
  ARM: dts: at91: at91sam9261: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9261ek: use TCB0 as timers
  ARM: dts: at91: at91sam9263: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9263ek: use TCB0 as timers
  ARM: dts: at91: calao: use TCB0 as timers
  ARM: dts: at91: at91sam9g45: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9m10g45ek: use TCB0 as timers
  ARM: dts: at91: pm9g45: use TCB0 as timers
  ARM: dts: at91: at91sam9rl: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9rlek: use TCB0 as timers
  ARM: dts: at91: at91sam9n12: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9n12ek: use TCB0 as timers
  ARM: dts: at91: at91sam9x5: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9x5cm: use TCB0 as timers
  ARM: dts: at91: acme/g25: use TCB0 as timers
  ARM: dts: at91: cosino: use TCB0 as timers
  ARM: dts: at91: kizboxmini: use TCB0 as timers
  ARM: dts: at91: sama5d3: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: sama5d3xek: use TCB0 as timers
  ARM: dts: at91: sama5d3 Xplained: use TCB0 as timers
  ARM: dts: at91: kizbox2: use TCB0 as timers
  ARM: dts: at91: sama5d3xek_cmp: use TCB0 as timers
  ARM: dts: at91: linea/tse850-3: use TCB0 as timers
  ARM: dts: at91: sama5d4: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: sama5d4: Add TCB2
  ARM: dts: at91: sama5d4ek: use TCB2 as timers
  ARM: dts: at91: sama5d4 Xplained: use TCB2 as timers
  ARM: dts: at91: ma5d4: use TCB2 as timers
  ARM: dts: at91: vinco: use TCB2 as timers
  ARM: dts: at91: sama5d2: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: sama5d2 Xplained: use TCB0 as timers
  ARM: dts: at91: sama5d27_som1_ek: use TCB0 as timers

 .../devicetree/bindings/arm/atmel-at91.txt         | 32 -------------
 .../devicetree/bindings/mfd/atmel-tcb.txt          | 56 ++++++++++++++++++++++
 arch/arm/boot/dts/animeo_ip.dts                    | 12 +++++
 arch/arm/boot/dts/at91-ariag25.dts                 | 12 +++++
 arch/arm/boot/dts/at91-ariettag25.dts              | 12 +++++
 arch/arm/boot/dts/at91-cosino.dtsi                 | 12 +++++
 arch/arm/boot/dts/at91-foxg20.dts                  | 12 +++++
 arch/arm/boot/dts/at91-kizbox.dts                  | 12 +++++
 arch/arm/boot/dts/at91-kizbox2.dts                 | 12 +++++
 arch/arm/boot/dts/at91-kizboxmini.dts              | 12 +++++
 arch/arm/boot/dts/at91-linea.dtsi                  | 12 +++++
 arch/arm/boot/dts/at91-qil_a9260.dts               | 12 +++++
 arch/arm/boot/dts/at91-sam9_l9260.dts              | 12 +++++
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        | 12 +++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        | 12 +++++
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        | 12 +++++
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          | 12 +++++
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        | 12 +++++
 arch/arm/boot/dts/at91-sama5d4ek.dts               | 12 +++++
 arch/arm/boot/dts/at91-vinco.dts                   | 12 +++++
 arch/arm/boot/dts/at91rm9200.dtsi                  |  8 +++-
 arch/arm/boot/dts/at91rm9200ek.dts                 | 12 +++++
 arch/arm/boot/dts/at91sam9260.dtsi                 |  8 +++-
 arch/arm/boot/dts/at91sam9260ek.dts                | 12 +++++
 arch/arm/boot/dts/at91sam9261.dtsi                 |  4 +-
 arch/arm/boot/dts/at91sam9261ek.dts                | 20 ++++++++
 arch/arm/boot/dts/at91sam9263.dtsi                 |  4 +-
 arch/arm/boot/dts/at91sam9263ek.dts                | 12 +++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        | 12 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  8 +++-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             | 12 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  8 +++-
 arch/arm/boot/dts/at91sam9n12ek.dts                | 12 +++++
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  4 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 | 12 +++++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  8 +++-
 arch/arm/boot/dts/at91sam9x5cm.dtsi                | 12 +++++
 arch/arm/boot/dts/ethernut5.dts                    | 12 +++++
 arch/arm/boot/dts/ge863-pro3.dtsi                  | 12 +++++
 arch/arm/boot/dts/mpa1600.dts                      | 12 +++++
 arch/arm/boot/dts/pm9g45.dts                       | 12 +++++
 arch/arm/boot/dts/sama5d2.dtsi                     |  8 +++-
 arch/arm/boot/dts/sama5d3.dtsi                     |  4 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi                |  4 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi                  | 12 +++++
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi              | 12 +++++
 arch/arm/boot/dts/sama5d4.dtsi                     | 18 ++++++-
 arch/arm/boot/dts/tny_a9260_common.dtsi            | 12 +++++
 arch/arm/boot/dts/tny_a9263.dts                    | 12 +++++
 arch/arm/boot/dts/usb_a9260_common.dtsi            | 12 +++++
 arch/arm/boot/dts/usb_a9263.dts                    | 12 +++++
 51 files changed, 575 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt

-- 
2.15.1
