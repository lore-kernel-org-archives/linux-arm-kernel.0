From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Fri, 8 Aug 2014 21:43:27 +0800
Subject: [PATCH v2 0/4] arm: mediatek: Add support for GIC interrupt polarity
 extension.
Message-ID: <1407505411-2207-1-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add support for mediatek GIC interrupt polarity extension.
Several components in mediatek SoC have low level triggered interrupt and
require this support.

This also correct 6589 timer irq polarity. Previous version works because
6589 boot loader already set correct polarity for timer interrupt.

The patch set is based on Matthias's Mediatek basic support for v3.17 [1].

v2:
- Make mt6589.dtsi changes as a separate commit as Matthias suggest.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272561.html

Joe.C (4):
  irqchip: gic: Change irq type check when extension is
  arm: mediatek: Add support for GIC interrupt polarity
  arm: mediatek: Add intpol in mt6589.dtsi
  dt-bindings: add bindings for mediatek intpol

 Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt |   16 ++
 arch/arm/boot/dts/mt6589.dtsi                                              |    7 -
 arch/arm/mach-mediatek/Makefile                                            |    2
 arch/arm/mach-mediatek/common.h                                            |   19 +++
 arch/arm/mach-mediatek/intpol.c                                            |   61 ++++++++++
 arch/arm/mach-mediatek/mediatek.c                                          |   10 +
 drivers/irqchip/irq-gic.c                                                  |   27 ++--
 7 files changed, 131 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt
 create mode 100644 arch/arm/mach-mediatek/common.h
 create mode 100644 arch/arm/mach-mediatek/intpol.c
