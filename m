From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 25 Sep 2013 18:28:17 -0300
Subject: [PATCH 0/5] Add Core Divider clock support for Armada 370/XP
Message-ID: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for a set of clocks available in Armada 370/XP
known as "Core Divider" clocks.

These are a set of gatable clocks, derived from a fixed PLL at
a configurable ratio. Although this patchset adds support for the more
general case, we only support one of the clocks, namely the NAND ECC clock.

With this infrastructure in place, the addition of the rest of the clocks
would be fairly easy.

In addition, the NAND clock is added as a fixed-ratio from the NAND ECC clock,
to model accurately the SoC clock tree.

A pictorical representation of the clock tree would be:

    PLL
    |
    |
    ---------------------
    |			|
    |			|
    NAND ECC clock	...
    |
    |
    NAND clock

This patchset is based on v3.12-rc2. Any opinions are highly appreciated.

Thanks!

Ezequiel Garcia (5):
  clk: mvebu: Add core-divider clock
  ARM: mvebu: Add Core Divider clock device-tree binding
  ARM: mvebu: Add a 2 GHz fixed-clock Armada 370/XP
  ARM: mvebu: Add the core-divider clock to Armada 370/XP
  ARM: mvebu: Add NAND clock to Armada 370/XP

 .../bindings/clock/mvebu-corediv-clock.txt         |  19 ++
 arch/arm/boot/dts/armada-370-xp.dtsi               |  25 +++
 drivers/clk/mvebu/Kconfig                          |   5 +
 drivers/clk/mvebu/Makefile                         |   1 +
 drivers/clk/mvebu/clk-corediv.c                    | 209 +++++++++++++++++++++
 5 files changed, 259 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
 create mode 100644 drivers/clk/mvebu/clk-corediv.c

-- 
1.8.1.5
