From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 Aug 2016 18:11:03 +0200
Subject: [PATCH 0/5] Atmel sama5d2 security module support
Message-ID: <20160831161108.8780-1-alexandre.belloni@free-electrons.com>
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

Regards,

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Alexandre Belloni (5):
  Documentation: dt: atmel-at91: Document secumod bindings
  ARM: dts: at91: sama5d2: Add secumod node
  ARM: at91: add secumod register definitions
  misc: sram: document new compatible
  misc: sram: add Atmel securam support

 .../devicetree/bindings/arm/atmel-at91.txt         | 17 +++++++
 Documentation/devicetree/bindings/sram/sram.txt    |  2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     | 19 ++++++++
 drivers/misc/sram.c                                | 52 +++++++++++++++++++---
 include/soc/at91/atmel-secumod.h                   | 46 +++++++++++++++++++
 5 files changed, 128 insertions(+), 8 deletions(-)
 create mode 100644 include/soc/at91/atmel-secumod.h

-- 
2.9.3
