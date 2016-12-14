From: jaghu@google.com (Jaghathiswari Rankappagounder Natarajan)
Date: Tue, 13 Dec 2016 23:55:00 -0800
Subject: [PATCH linux v1 0/4] Seven segment display support
Message-ID: <1481702104-8617-1-git-send-email-jaghu@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset includes:

Documentation for the binding which provides an interface for adding clock,
data and clear signal GPIO lines to control seven segment display.

The platform device driver provides an API for displaying on two 7-segment
displays, and implements the required bit-banging. The hardware assumed is
74HC164 wired to two 7-segment displays.

The character device driver implements the user-space API for letting a user
write to two 7-segment displays including any conversion methods necessary
to map the user input to two 7-segment displays.

Adding clock, data and clear signal GPIO lines in the devicetree to control
seven segment display on zaius platform.

The platform driver matches on the device tree node; the platform driver also
initializes the character device.

Tested that the seven segment display works properly by writing to the
character device file on a EVB AST2500 board which also has 74HC164 wired
to two 7-segment displays.

Jaghathiswari Rankappagounder Natarajan (4):
  Documentation: dt-bindings: Document bindings for seven segment
    display support
  drivers: misc: Character device driver for seven segment display
  drivers: misc: Platform driver for seven segment display support
  arm: dts: Add dt-binding to support seven segment display on zaius

 .../devicetree/bindings/misc/seven-seg-gpio.txt    |  27 +++
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |   8 +
 drivers/misc/Kconfig                               |  16 ++
 drivers/misc/Makefile                              |   2 +
 drivers/misc/seven_seg_disp.c                      | 197 ++++++++++++++++++++
 drivers/misc/seven_seg_disp.h                      |  34 ++++
 drivers/misc/seven_seg_gpio.c                      | 206 +++++++++++++++++++++
 7 files changed, 490 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/seven-seg-gpio.txt
 create mode 100644 drivers/misc/seven_seg_disp.c
 create mode 100644 drivers/misc/seven_seg_disp.h
 create mode 100644 drivers/misc/seven_seg_gpio.c

--
2.8.0.rc3.226.g39d4020
