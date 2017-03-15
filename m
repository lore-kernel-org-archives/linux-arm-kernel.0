From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 15 Mar 2017 23:51:36 +0800
Subject: [PATCH 0/4] Add support for Nsiway NS2009 touchscreen controller
Message-ID: <20170315155140.54518-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The production batch of Lichee Pi Zero board have a Nsiway NS2009 touchscreen
controller on board, which is used for connecting resistive touch panels on
40-pin LCD connector.

This patchset adds support for it.

Patch 1 adds vendor prefix for Nsiway, and patch 2 adds device tree binding
for NS2009.

Patch 3 is the real driver of NS2009, which currently supports only polling
(as the IRQ pin is not connected on Lichee Pi Zero).

Patch 4 adds NS2009 node to Lichee Pi Zero device tree.

Icenowy Zheng (4):
  dt-bindings: add vendor prefix for Shenzhen Nsiway Techonology Co.,
    Ltd.
  dt-bindings: add binding for Nsiway NS2009 touchscreen controller
  Input: add driver for Nsiway NS2009 resistive touchscreen controller
  ARM: sun8i: v3s: add ns2009 node for Lichee Pi Zero board

 .../bindings/input/touchscreen/ns2009.txt          |  23 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts      |   9 +
 drivers/input/touchscreen/Kconfig                  |  13 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/ns2009.c                 | 212 +++++++++++++++++++++
 7 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ns2009.txt
 create mode 100644 drivers/input/touchscreen/ns2009.c

-- 
2.12.0
