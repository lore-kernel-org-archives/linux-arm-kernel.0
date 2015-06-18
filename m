From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 18 Jun 2015 13:52:50 +0200
Subject: [PATCH v2 0/3] Add DT support for netxbig LEDs
Message-ID: <1434628373-11834-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds DT support for the LEDs found on the Kirkwood-based
LaCie boards 2Big and 5Big Network v2.

Changes since v1:
- Check timer mode value retrieved from DT.
- In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
  timer delay values from DT with function of_property_read_u32_index.
  Instead, use a temporary u32 variable. This allows to silence a static
  checker warning.
- Make timer property optional in the binding documentation. It is now
  aligned with the driver code.

Simon

Simon Guinot (3):
  leds: netxbig: add device tree binding
  ARM: Kirkwood: add LED DT entries for netxbig boards
  ARM: mvebu: remove static LED setup for netxbig boards

 .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
 .../devicetree/bindings/leds/leds-netxbig.txt      |  92 ++++++++
 arch/arm/boot/dts/kirkwood-net5big.dts             |  60 +++++
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            |  80 +++++++
 arch/arm/mach-mvebu/Kconfig                        |   7 -
 arch/arm/mach-mvebu/Makefile                       |   1 -
 arch/arm/mach-mvebu/board.h                        |  21 --
 arch/arm/mach-mvebu/kirkwood.c                     |   4 -
 arch/arm/mach-mvebu/netxbig.c                      | 191 ----------------
 drivers/leds/leds-netxbig.c                        | 250 +++++++++++++++++++--
 include/dt-bindings/leds/leds-netxbig.h            |  18 ++
 11 files changed, 501 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
 delete mode 100644 arch/arm/mach-mvebu/board.h
 delete mode 100644 arch/arm/mach-mvebu/netxbig.c
 create mode 100644 include/dt-bindings/leds/leds-netxbig.h

-- 
2.1.4
