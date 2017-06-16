From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jun 2017 18:26:08 +0200
Subject: [GIT PULL] ARM: at91: DT for 4.13
Message-ID: <20170616162608.ucjxtqpvjhdj77gy@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is the DT pull request, switching most platform the the new EBI and
NAND bindings.

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.13-dt

for you to fetch changes up to bc03ce08396786c92d6591a81682c7da7accbfc8:

  ARM: dts: at91: sama5d2_xplained: remove wrong memory node (2017-06-08 23:49:17 +0200)

----------------------------------------------------------------
DT for 4.13

 - Switch to the new NAND binding
 - A few non urgent fixes

----------------------------------------------------------------
Baruch Siach (1):
      ARM: dts: at91: sama5d2_xplained: remove wrong memory node

Boris Brezillon (4):
      dt-bindings: mtd: atmel-nand: Document the nfc-io bindings
      ARM: dts: at91: Declare EBI/NAND controllers
      ARM: dts: at91: Switch to the new NAND bindings
      ARM: dts: at91: Add the NOR flash available on sama5d3 dev kits

Claudiu Beznea (1):
      ARM: dts: at91: sama5d2_xplained: add pwm controller

Javier Martinez Canillas (1):
      ARM: dts: at91: Add generic compatible string for I2C EEPROM

Uwe Kleine-K?nig (2):
      dts: gpio_atmel: adapt binding doc to reality
      ARM: dts: at91-sama5d4: use IRQ_TYPE_* to specify irq flags

Wenyou Yang (1):
      ARM: dts: at91: sama5d2: add m_can nodes

 .../devicetree/bindings/gpio/gpio_atmel.txt        |  10 +-
 .../devicetree/bindings/mtd/atmel-nand.txt         |  14 ++
 arch/arm/boot/dts/aks-cdu.dts                      |  56 ++++---
 arch/arm/boot/dts/animeo_ip.dts                    |  53 ++++--
 arch/arm/boot/dts/at91-cosino.dtsi                 |  83 ++++++----
 arch/arm/boot/dts/at91-kizbox.dts                  |  42 +++--
 arch/arm/boot/dts/at91-kizbox2.dts                 |  45 ++++--
 arch/arm/boot/dts/at91-kizboxmini.dts              |  52 ++++--
 arch/arm/boot/dts/at91-linea.dtsi                  |  27 +++-
 arch/arm/boot/dts/at91-qil_a9260.dts               | 103 +++++++-----
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  32 +++-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  97 ++++++-----
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |   4 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  83 ++++++----
 arch/arm/boot/dts/at91-sama5d4ek.dts               |  83 ++++++----
 arch/arm/boot/dts/at91-tse850-3.dts                |  72 +++++----
 arch/arm/boot/dts/at91sam9260.dtsi                 |  65 +++++---
 arch/arm/boot/dts/at91sam9261.dtsi                 |  48 ++++--
 arch/arm/boot/dts/at91sam9261ek.dts                |  83 ++++++----
 arch/arm/boot/dts/at91sam9263.dtsi                 |  89 ++++++++---
 arch/arm/boot/dts/at91sam9263ek.dts                | 103 +++++++-----
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        | 103 +++++++-----
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  64 +++++---
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |  49 ++++--
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  74 ++++++---
 arch/arm/boot/dts/at91sam9n12ek.dts                |  26 ++-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  69 +++++---
 arch/arm/boot/dts/at91sam9rlek.dts                 |  85 ++++++----
 arch/arm/boot/dts/at91sam9x5.dtsi                  | 134 ++++++++++------
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |  83 ++++++----
 arch/arm/boot/dts/ethernut5.dts                    |  47 ++++--
 arch/arm/boot/dts/ge863-pro3.dtsi                  |  41 +++--
 arch/arm/boot/dts/pm9g45.dts                       |  99 ++++++------
 arch/arm/boot/dts/sama5d2.dtsi                     | 117 ++++++++++++++
 arch/arm/boot/dts/sama5d3.dtsi                     | 131 ++++++++++++---
 arch/arm/boot/dts/sama5d3xcm.dtsi                  |  97 +++++++----
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi              |  77 +++++----
 arch/arm/boot/dts/sama5d4.dtsi                     | 177 ++++++++++++++++++---
 arch/arm/boot/dts/tny_a9260_common.dtsi            |  89 +++++++----
 arch/arm/boot/dts/tny_a9263.dts                    | 103 +++++++-----
 arch/arm/boot/dts/usb_a9260_common.dtsi            | 103 +++++++-----
 arch/arm/boot/dts/usb_a9263.dts                    | 103 +++++++-----
 42 files changed, 2096 insertions(+), 1019 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
