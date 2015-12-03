From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Dec 2015 16:20:09 +0800
Subject: [PATCH 0/4] ARM: sun9i: Support Allwinner A80 NMI controller
Message-ID: <1449130813-22400-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series extends irqchip-sunxi-nmi to add support for the NMI
controller found in Allwinner's A80 SoC.

All Allwinner SoCs have an external NMI pin which the PMIC uses to
signal interrupts to the processor. On multi-core chips, there's an
NMI controller handling this pin and chaining interrupts to the GIC.
We already have support for this on previous sun[678]i family chips.

This series extends support to the A80 SoC. This is needed to add
support for the PMICs. A complete series, including PMIC support,
can be found here:

    https://github.com/wens/linux/tree/axp809

Patch 1 renames the binding doc, to remove the SoC specific bits from
the filename.

Patch 2 adds a new compatible string for the A80 variant.

Patch 3 adds driver support for the A80 variant.

Patch 4 adds the NMI controller device node to the A80 dtsi file.

Chen-Yu Tsai (4):
  irqchip/sunxi-nmi: Rename binding doc filename to
    allwinner,sunxi-nmi.txt
  irqchip/sunxi-nmi: Add sun9i-a80 variant to binding doc
  irqchip/sunxi-nmi: Support sun9i A80 NMI controller
  ARM: dts: sun9i: Add NMI controller device node

 ...{allwinner,sun67i-sc-nmi.txt => allwinner,sunxi-nmi.txt} |  2 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                            |  8 ++++++++
 drivers/irqchip/irq-sunxi-nmi.c                             | 13 +++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/interrupt-controller/{allwinner,sun67i-sc-nmi.txt => allwinner,sunxi-nmi.txt} (94%)

-- 
2.6.2
