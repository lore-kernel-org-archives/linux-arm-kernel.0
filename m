From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 15 Jul 2016 22:58:26 +0200
Subject: [GIT PULL] ARM: at91: dt for 4.8 #3
Message-ID: <20160715205826.GA31997@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here is a PR including a fix for kernelci and many fixes for DTC
warnings.
As discussed with Arnd, the PMC ones are not that easy to fix and will
require some code changes. I'll try to take care of those for 4.9.

The following changes since commit b8bca7eaef9eeda4876b8ded1f49862b0b85181c:

  ARM: dts: at91: sama5d2_xplained: Update the pmic node (2016-07-04 15:59:46 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-dt3

for you to fetch changes up to 7aff0f29cdb484a5d9692a4d6c9e4b908a848688:

  ARM: dts: at91: Don't build unnecessary dtbs (2016-07-15 11:23:59 +0200)

----------------------------------------------------------------
DT Changes for 4.8 #3:
 - Lot of fixes for dtc warnings
 - Separate dtb compilation for ARMv4 and ARMv5

----------------------------------------------------------------
Alexandre Belloni (15):
      Documentation: dt: iio: at91_adc: fix trigger node names
      ARM: dts: at91: Fix ADC trigger nodes
      Documentation: dt: usb: atmel-usb: add unit-address
      ARM: dts: at91: Fix USB endpoint nodes
      ARM: dts: at91: sama5d4ek: remove useless lcd_bus
      ARM: dts: at91: sama5d3_xplained: fix regulator name
      ARM: dts: at91: sama5d4_xplained: fix regulator names
      ARM: dts: at91: sama5d4_ma5d4: fix regulator names
      ARM: dts: at91: sama5d4_ma5d4evk: fix regulator names
      ARM: dts: at91: ariag25 : fix onewire node
      ARM: dts: at91: vinco: fix regulator name
      ARM: dts: at91: fix i2c-gpio node name
      ARM: dts: at91: move isi definition to at91sam9g25ek
      ARM: dts: at91: at91sam9g25ek: fix isi endpoint node
      ARM: dts: at91: sama5d3x: separate motherboard gmac and emac definitions

Arnd Bergmann (1):
      ARM: dts: at91: Don't build unnecessary dtbs

 .../devicetree/bindings/iio/adc/at91_adc.txt       | 12 ++----
 .../devicetree/bindings/usb/atmel-usb.txt          | 14 +++----
 arch/arm/boot/dts/Makefile                         |  5 ++-
 arch/arm/boot/dts/at91-ariag25.dts                 |  2 +-
 arch/arm/boot/dts/at91-foxg20.dts                  |  2 +-
 arch/arm/boot/dts/at91-kizbox.dts                  |  2 +-
 arch/arm/boot/dts/at91-qil_a9260.dts               |  2 +-
 arch/arm/boot/dts/at91-sam9_l9260.dts              |  2 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |  4 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts        |  2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  4 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts               | 20 ---------
 arch/arm/boot/dts/at91-vinco.dts                   |  2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |  2 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 | 14 +++----
 arch/arm/boot/dts/at91sam9260ek.dts                |  2 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |  2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |  2 +-
 arch/arm/boot/dts/at91sam9g25ek.dts                | 26 ++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 | 28 ++++++-------
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  | 30 ++++++--------
 arch/arm/boot/dts/at91sam9rlek.dts                 |  4 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  | 32 +++++++--------
 arch/arm/boot/dts/at91sam9x5ek.dtsi                | 33 ---------------
 arch/arm/boot/dts/ethernut5.dts                    |  2 +-
 arch/arm/boot/dts/evk-pro3.dts                     |  2 +-
 arch/arm/boot/dts/mpa1600.dts                      |  2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     | 32 +++++++--------
 arch/arm/boot/dts/sama5d3.dtsi                     | 44 +++++++++-----------
 arch/arm/boot/dts/sama5d31ek.dts                   |  1 +
 arch/arm/boot/dts/sama5d33ek.dts                   |  1 +
 arch/arm/boot/dts/sama5d34ek.dts                   |  1 +
 arch/arm/boot/dts/sama5d35ek.dts                   |  2 +
 arch/arm/boot/dts/sama5d36ek.dts                   |  2 +
 arch/arm/boot/dts/sama5d3xcm.dtsi                  | 34 ---------------
 arch/arm/boot/dts/sama5d3xmb.dtsi                  | 12 ------
 arch/arm/boot/dts/sama5d3xmb_emac.dtsi             | 26 ++++++++++++
 arch/arm/boot/dts/sama5d3xmb_gmac.dtsi             | 48 ++++++++++++++++++++++
 arch/arm/boot/dts/sama5d4.dtsi                     | 40 +++++++++---------
 arch/arm/boot/dts/tny_a9263.dts                    |  2 +-
 arch/arm/boot/dts/usb_a9260_common.dtsi            |  2 +-
 arch/arm/boot/dts/usb_a9263.dts                    |  2 +-
 arch/arm/boot/dts/usb_a9g20_common.dtsi            |  2 +-
 47 files changed, 249 insertions(+), 264 deletions(-)
 create mode 100644 arch/arm/boot/dts/sama5d3xmb_emac.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d3xmb_gmac.dtsi

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/3050ebec/attachment.sig>
