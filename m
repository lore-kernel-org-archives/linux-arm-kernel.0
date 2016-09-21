From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 22 Sep 2016 00:09:33 +0200
Subject: [PATCH v2 0/6] Atmel sama5d2 security module support
Message-ID: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There has already been multiple tentatives trying to add support for the
Sama5d2 security module and in particular, access to its SRAM.
After multiple discussions, I believe adding support in the sram
driver/framework is probably the best because it allows exporting the
SRAM to the kernel, to userspace and also to run code from it.

As the support for the sama5d2 securam is fairly small, I've included it
directly in the mmio-sram driver.

Changes in v2:
 - Fixed an issued in the sama5d2 dtsi
 - Use regmap_read_poll_timeout and of_device_get_match_data as suggested by
   Philipp
 - Shrink the timeout to 500ms
 - Added Rob's acks

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Alexandre Belloni (6):
  Documentation: dt: atmel-at91: Document secumod bindings
  ARM: at91: add secumod register definitions
  ARM: dts: at91: sama5d2: Add secumod node
  misc: sram: document new compatible
  misc: sram: add Atmel securam support
  ARM: dts: at91: sama5d2: Add securam node

 .../devicetree/bindings/arm/atmel-at91.txt         | 17 +++++++++
 Documentation/devicetree/bindings/sram/sram.txt    |  2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     | 19 ++++++++++
 drivers/misc/sram.c                                | 42 ++++++++++++++++++----
 include/soc/at91/atmel-secumod.h                   | 20 +++++++++++
 5 files changed, 92 insertions(+), 8 deletions(-)
 create mode 100644 include/soc/at91/atmel-secumod.h

-- 
2.9.3
