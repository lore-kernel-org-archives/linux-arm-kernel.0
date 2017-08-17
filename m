From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 17 Aug 2017 12:11:37 +0200
Subject: [RFC 0/3] arm64: Realtek RTD1295 IRQ mux
Message-ID: <20170817101140.32000-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds two IRQ muxes for the Realtek RTD1295 SoC.
Based on the reset controller series.

There being no public source code for RTD1295, the implementation is based on
register offsets seen in the DT, split up into two separate nodes.

A workaround for hanging timer initialization was taken from QNAP's rtk119x
GPL code dump and is not yet fully understood; that code also contains a quirk
for i2c3 in the iso mux that is not yet verified to be needed on RTD1295,
for lack of i2c driver, assuming a linear intr_status/intr_en mapping for now.

My convention here is to use a compatible string for the model that I've
tested (RTD1295) but a file name of rtd119x to indicate its RTD1195 heritage.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Roc He <hepeng@zidoo.tv>
Cc: ??? <jiang.liqin@geniatech.com>
Cc: devicetree at vger.kernel.org

Andreas F?rber (3):
  dt-bindings: interrupt-controller: Add Realtek RTD1295
  arm64: dts: realtek: Add irq mux to RTD1295
  irqchip: Add Realtek RTD1295 mux driver

 .../interrupt-controller/realtek,rtd119x-mux.txt   |  28 +++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |  22 +++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-rtd119x-mux.c                  | 201 +++++++++++++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt
 create mode 100644 drivers/irqchip/irq-rtd119x-mux.c

-- 
2.12.3
