From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 27 Feb 2014 19:47:51 +0100
Subject: [PATCHv2 0/7] at91_adc: documentation and device tree cleanups
Message-ID: <1393526878-22311-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch synchronise the documentation with the actual code and correct
the example.

The second patch move the documentation to the correct location (under iio/adc)

The remaining patches correct the device trees that are using the adc, mainly
removing unused properties and making the binding compliant with the ePAPR.

Changes in v2:
 - add #address-cells, #size-cells and a reg for each trigger to comply to the
   ePAPR instead of removing the unit-address.
 - also correct the atmel,adc-use-external-triggers property name in the
   documentation and in the device tree that got it wrong.


Alexandre Belloni (7):
  Documentation: dt: iio: improve atmel-adc documentation
  Documentation: dt: iio: move arm/atmel-adc.txt to iio/adc/at91_adc.txt
  ARM: at91/dt: at91-ariag25: remove useless adc properties
  ARM: at91/dt: at91sam9260: remove useless adc properties
  ARM: at91/dt: at91sam9g45: remove useless adc properties
  ARM: at91/dt: at91sam9x5: remove useless adc properties
  ARM: at91/dt: sama5d3: remove useless adc properties

 .../devicetree/bindings/arm/atmel-adc.txt          | 81 ---------------------
 .../devicetree/bindings/iio/adc/at91_adc.txt       | 82 ++++++++++++++++++++++
 arch/arm/boot/dts/at91-ariag25.dts                 |  1 -
 arch/arm/boot/dts/at91sam9260.dtsi                 | 11 +--
 arch/arm/boot/dts/at91sam9g45.dtsi                 | 11 +--
 arch/arm/boot/dts/at91sam9x5.dtsi                  | 13 ++--
 arch/arm/boot/dts/sama5d3.dtsi                     | 13 ++--
 7 files changed, 108 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt

-- 
1.8.3.2
