From: david@lechnology.com (David Lechner)
Date: Fri, 13 Jan 2017 13:03:38 -0600
Subject: [PATCH v4 0/4] Support for LEGO MINDSTORMS EV3
Message-ID: <1484334222-14223-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for LEGO MINDSTORMS EV3. This is a TI AM1808
based board.

v4 changes:
* New patches for device tree bindings specifications
* Fixed vendor on eeprom device node

v3 changes:
* required defconfig patches have been picked up in linux-davinci tree, so this
  is the only patch left in the series
* Added aliases node for consistent naming of serial ports
* Added memory node
* Removed nodes that are not finalized yet
* Renamed button labels to match EV3 users manual

v2 changes:
* Dropped defconfig patches that have already been pick up
* Added some new defconfig patches
* Updated device tree file based on feedback and new available bindings
  * Renamed file to include da850- prefix
  * Changed button labels
  * Fixed LED names
  * Added beeper device for sound
  * Added regulators for USB and A/DC
  * Removed unused pinmux nodes
  * Added pinconf for buttons
  * Enabled pwms
  * Used preferred bindings for flash partitions
  * Added A/DC spi device
  * Enabled USB


David Lechner (4):
  dt-bindings: Add vendor prefix for LEGO
  dt-bindings: Add LEGO MINDSTORMS EV3 compatible specification
  dt-bindings: add "microchip,24c128" compatible string
  ARM: dts: Add LEGO MINDSTORMS EV3 dts

 Documentation/devicetree/bindings/arm/davinci.txt  |   4 +
 .../devicetree/bindings/eeprom/eeprom.txt          |   2 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/da850-lego-ev3.dts               | 313 +++++++++++++++++++++
 5 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/da850-lego-ev3.dts

-- 
2.7.4
