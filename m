From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Aug 2014 12:24:54 -0700
Subject: [PATCH v3 0/5] ARM: add Broadcom BCM63138 support
Message-ID: <1408389899-1022-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patchset adds very minimal support for the BCM63138 SoC which is
a xDSL SoC using a dual Cortex A9 CPU complex.

Future work will focus on:

- clock device/driver/providers
- SMP support
- enabling more existing bcm63xx drivers to be DT enabled

Florian Fainelli (5):
  ARM: BCM63XX: add basic support for the Broadcom BCM63138 DSL SoC
  ARM: BCM63XX: add low-level UART debug support
  ARM: BCM63XX: add BCM63138 minimal Device Tree
  ARM: BCM63XX: add BCM963138DVT Reference platform DTS
  MAINTAINERS: add entry for the Broadcom BCM63xx ARM SoCs

 .../devicetree/bindings/arm/bcm/bcm63138.txt       |   9 ++
 MAINTAINERS                                        |   8 ++
 arch/arm/Kconfig.debug                             |  18 ++-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm63138.dtsi                    | 134 +++++++++++++++++++++
 arch/arm/boot/dts/bcm963138dvt.dts                 |  30 +++++
 arch/arm/include/debug/bcm63xx.S                   |  33 +++++
 arch/arm/mach-bcm/Kconfig                          |  17 +++
 arch/arm/mach-bcm/Makefile                         |   3 +
 arch/arm/mach-bcm/bcm63xx.c                        |  27 +++++
 10 files changed, 278 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
 create mode 100644 arch/arm/boot/dts/bcm63138.dtsi
 create mode 100644 arch/arm/boot/dts/bcm963138dvt.dts
 create mode 100644 arch/arm/include/debug/bcm63xx.S
 create mode 100644 arch/arm/mach-bcm/bcm63xx.c

-- 
1.9.1
