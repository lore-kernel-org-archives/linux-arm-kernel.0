From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Aug 2017 12:53:41 +0200
Subject: [PATCH v2 0/3] arm64: Realtek RTD1295 IRQ mux
Message-ID: <20170828105344.8338-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds two IRQ muxes for the Realtek RTD1295 SoC.

There being no public source code for RTD1295, the implementation is based on
register offsets seen in the vendor DT, split up into two separate nodes,
as well as code from QNAP's rtk119x GPL code dump.

v2 does various cleanups, including limiting the serial quirk to the iso mux.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* Rebased, avoiding dependency on reset series for DT nodes
* Don't forward set_affinity to GIC (Marc)
* Added more spinlocks (Marc)
* Code cleanups
* Investigated quirk
* Fixed spinlock initialization (Andrew)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Roc He <hepeng@zidoo.tv>
Cc: ??? <jiang.liqin@geniatech.com>
Cc: devicetree at vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>

Andreas F?rber (3):
  dt-bindings: interrupt-controller: Add Realtek RTD1295
  irqchip: Add Realtek RTD1295 mux driver
  arm64: dts: realtek: Add irq mux to RTD1295

 .../interrupt-controller/realtek,rtd119x-mux.txt   |  23 +++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |  22 +++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-rtd119x-mux.c                  | 204 +++++++++++++++++++++
 4 files changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt
 create mode 100644 drivers/irqchip/irq-rtd119x-mux.c

-- 
2.12.3
