From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 22 Sep 2018 17:09:58 +0200
Subject: [PATCH v2 0/5] Meson8b: add support for the Endless Mini EC-100
Message-ID: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the "Endless Mini" grapefruit-sized mini PC
from Endless Mobile, Inc. The internal name of this device is EC-100
(this can be found for example in the GPL kernel tree which is based on
Amlogic's 3.10 kernel: [0]).

The board is using a Meson8b (S805) SoC with various peripherals.
The biggest difference compared to boards which are based on Amlogic's
reference designs is that this board comes with an embedded micro-
controller called "EC" which makes the system LED pulse during boot
and allows powering off the board. It also comes with a 10/100 Mbit/s
Ethernet port and one USB host port.
There are two variants:
- 2GB RAM, 32GB storage, 802.11bgn and Bluetooth 4.0
- 1GB RAM, 24GB storage, neither wifi nor Bluetooth

This series contains support for the new board as well as supporting
patches for the new vendor prefix and the pin definitions in
meson8b.dtsi so various peripherals can be enabled.


Changes since v1 at [1]:
- added Rob's "Acked-by" to the dt-bindings patches (#1 and #2)
- changed the compatible string from endless,ec-100 to endless,ec100 to
  match what is being shipped with the 3.10 based kernel (suggested by
  Daniel Drake) as well as being consistent with the .dts file naming


[0] https://github.com/endlessm/linux-meson/blob/d628bf1242928927a41f7482ba5ef7295e01a9ff/arch/arm/boot/dts/meson8b-ec100.dts
[1] http://lists.infradead.org/pipermail/linux-amlogic/2018-September/008342.html

Martin Blumenstingl (5):
  dt-bindings: add vendor prefix for "Endless Mobile, Inc."
  dt-bindings: arm: amlogic: Add the Endless Mobile Endless Mini
    (EC-100)
  ARM: dts: meson8b: add the I2C_A, PWM_C and UART_B pins
  ARM: dts: meson8b: add the RMII pins
  ARM: dts: meson8b: Add support for the Endless Mini (EC-100)

 .../devicetree/bindings/arm/amlogic.txt       |   1 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/meson8b-ec100.dts           | 248 ++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi                |  45 ++++
 5 files changed, 296 insertions(+)
 create mode 100644 arch/arm/boot/dts/meson8b-ec100.dts

-- 
2.19.0
