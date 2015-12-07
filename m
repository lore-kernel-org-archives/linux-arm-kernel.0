From: plaes@plaes.org (Priit Laes)
Date: Mon,  7 Dec 2015 09:25:59 +0200
Subject: [PATCH 0/2] input: Driver for Goodix GT801 2+1 touchscreen
Message-ID: <1449473161-3535-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Goodix GT801 2+1 touchscreen controller
and hooks it up on Gemei G9 tablet.

Now about GT801 2+1 - I initially tried to implement this inside the
existing Goodix driver, but unfortunately there are too many small
bits and pieces that would make the otherwise simple driver a
complicated mess:
  - endianness differences of coordinate readouts
  - totally different touch protocol
  - configuration layout and version information
  - I2C register differences (2 bytes vs single byte)

To apply the patchset, you need both linux-input/next and
linux-sunxi/next merged.

Patch 1 (Gemei G9 devicetree bits) should go via linux-sunxi tree.
Patch 2 (GT801 2+1 driver implementation) via linux-input

Priit Laes (2):
  ARM: dts: sun4i: gemei-g9: Add touchscreen (Goodix gt801x2) support
  input: gt801_2plus1 - Add initial support for Goodix GT801 2+1

 .../bindings/input/touchscreen/gt801_2plus1.txt    |  23 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |  26 +-
 drivers/input/touchscreen/Kconfig                  |  19 +-
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/gt801_2plus1.c           | 375 +++++++++++++++++++++
 6 files changed, 445 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/gt801_2plus1.txt
 create mode 100644 drivers/input/touchscreen/gt801_2plus1.c

-- 
2.6.3
